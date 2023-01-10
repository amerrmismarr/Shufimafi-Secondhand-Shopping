import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dolabi/screens/login.dart';
import 'package:dolabi/screens/product_details.dart';
import 'package:dolabi/screens/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../services/local_notifications_service.dart';

class HomeLoggedIn extends StatefulWidget {
  ScrollController? scrollController;
  HomeLoggedIn({this.scrollController});

  @override
  State<HomeLoggedIn> createState() => _HomeLoggedInState(scrollController);
}

class _HomeLoggedInState extends State<HomeLoggedIn> {
  ScrollController? scrollController;
  _HomeLoggedInState(this.scrollController);
  Color mainColor = const Color.fromARGB(255, 255, 115, 0);
  String searchingText = 'Search.......';
  var uuid = Uuid();

  late String notificationId;

  sendNotification(String title, String token) async {
    notificationId = uuid.v1();
    final data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': notificationId,
      'status': 'done',
      'message': title,
    };

    try {
      http.Response response =
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization':
                    'key=AAAAHCmmD6I:APA91bFmHloueY2g3dk9qZ7jxx4patrg515GdOwZmY-ZzjoqXi1w3CoiknNx8pcu6NoSP3PesGgtJXwI1-7mQoiM3EcjcmoY43n6VWYgc0OsuZoeohtMxG666FcH0IxZMp1BB2OgqHL8'
              },
              body: jsonEncode(<String, dynamic>{
                'notification': <String, dynamic>{
                  'title': title,
                  'body': 'Click to see who!'
                },
                'priority': 'high',
                'data': data,
                'to': '$token'
              }));

      if (response.statusCode == 200) {
        print('Notification sent');
      } else {
        print('errorrr');
      }
    } catch (e) {}
  }

  Widget _buildFeaturedProduct(
      String name,
      String price,
      String image,
      String productId,
      List favorites,
      String token,
      String userId,
      String username) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          height: 240,
          width: 170,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Container(
                  height: 200,
                  width: 160,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(image), fit: BoxFit.cover)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          'JOD' + ' ' + price.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.grey),
                        ),
                      ),
                      Container(
                        width: 100,
                        child: Text(
                          name,
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                  favorites.contains(productId)
                      ? IconButton(
                          icon: Icon(Icons.favorite,
                              size: screenAwareSize(20.0, context),
                              color: mainColor),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('Users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .set({
                              'favorites': FieldValue.arrayRemove([productId])
                            }, SetOptions(merge: true));
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.favorite_border,
                              size: screenAwareSize(20.0, context),
                              color: mainColor),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('Users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .set({
                              'favorites': FieldValue.arrayUnion([productId])
                            }, SetOptions(merge: true));
                            sendNotification(
                                'Someone likes your product', token);
                            FirebaseFirestore.instance
                                .collection('Users')
                                .doc(userId)
                                .collection('Notifications')
                                .doc(notificationId)
                                .set({
                              'title': 'likes your product',
                              'username': username,
                              'image': image
                            });
                          },
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategory(String image, String searchText, Color color) {
    return GestureDetector(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: Search(
            searchText: searchText,
          ),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.slideUp,
        );
      },
      child: Row(
        children: [
          Container(
            height: 100,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(100.0)),
              border: Border.all(
                color: mainColor,
                width: 2.0,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: color,
              maxRadius: 37,
              child: Container(
                  height: 40,
                  child: Image(
                      color: mainColor, image: AssetImage('images/$image'))),
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.display(event);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CarouselController controller = CarouselController();
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot firstSnapshot) {
            if (!firstSnapshot.hasData) {
              return CircularProgressIndicator();
            }
            List favorites = firstSnapshot.data!.get('favorites');
            return ListView(
              controller: scrollController,
              children: <Widget>[
                CarouselSlider.builder(
                  carouselController: controller,
                  options: CarouselOptions(
                      viewportFraction: 1,
                      aspectRatio: 2.5,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: true,
                      initialPage: 0,
                      autoPlay: true,
                      onPageChanged: (val, _) {
                        setState(() {
                          //   print("new index $val");
                          //   controller.jumpToPage(val);
                        });
                      }),
                  itemCount: 3,
                  itemBuilder: (context, index, int pageViewIndex) {
                    return GestureDetector(
                        onTap: () {},
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 0),
                          child: index == 0
                              ? Container(
                                  width: double.infinity,
                                  height: screenAwareSize(100, context),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('images/logo.png'),
                                          fit: BoxFit.fitHeight)),
                                )
                              : index == 1
                                  ? Container(
                                      width: double.infinity,
                                      height: screenAwareSize(100, context),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'images/advertise.png'),
                                              fit: BoxFit.fitHeight)),
                                    )
                                  : Container(
                                      width: double.infinity,
                                      height: screenAwareSize(100, context),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'images/donate.png'),
                                              fit: BoxFit.fitHeight)),
                                    ),
                        ));
                  },
                ),
                Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        'Quick search',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  child: ListView(scrollDirection: Axis.horizontal, children: <
                      Widget>[
                    _buildCategory('dress_icon.png', 'Women', Colors.white),
                    _buildCategory('shoes_icon.png', 'Shoes', Colors.white),
                    _buildCategory('tie_icon.png', 'Ties', Colors.white),
                    _buildCategory('shirt.png', 'T-Shirts', Colors.white),
                    _buildCategory('watch_icon.png', 'Watches', Colors.white),
                    _buildCategory('shirt.png', 'Watches', Colors.white),
                    _buildCategory('watch_icon.png', 'Watches', Colors.white),
                    _buildCategory('shirt.png', 'Watches', Colors.white),
                    _buildCategory('watch_icon.png', 'Watches', Colors.white),
                    _buildCategory('shirt.png', 'Watches', Colors.white),
                    _buildCategory('watch_icon.png', 'Watches', Colors.white),
                  ]),
                ),
                Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        'Newest products',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Products')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    var products = snapshot.data.docs;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.60,
                              crossAxisSpacing: 3,
                              crossAxisCount: 2),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        var token = snapshot.data.docs[index]['token'];
                        var userId = snapshot.data.docs[index]['userId'];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    duration: Duration(milliseconds: 1000),
                                    type: PageTransitionType.fade,
                                    child: ProductDetails(
                                      image: products[index]['image'],
                                      name: products[index]['name'],
                                      price: '1999',
                                      productId: products[index]['productId'],
                                    )));
                          },
                          child: _buildFeaturedProduct(
                              products[index]['brand'],
                              products[index]['price'],
                              products[index]['image'],
                              products[index]['productId'],
                              favorites,
                              token,
                              userId,
                              firstSnapshot.data['Username']),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            );
          }),
    );
  }
}
