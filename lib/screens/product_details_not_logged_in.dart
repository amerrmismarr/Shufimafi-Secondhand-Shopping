import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dolabi/screens/home.dart';
import 'package:dolabi/screens/tabs_with_screens.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login.dart';

class ProductDetailsNotLoggedIn extends StatefulWidget {
  String? image;
  String? name;
  String? price;
  String? productId;
  String? category;
  String? brand;

  ProductDetailsNotLoggedIn(
      {this.image,
      this.name,
      this.price,
      this.productId,
      this.category,
      this.brand});

  @override
  State<ProductDetailsNotLoggedIn> createState() =>
      _ProductDetailsNotLoggedInState();
}

class _ProductDetailsNotLoggedInState extends State<ProductDetailsNotLoggedIn> {
  int count = 1;
  Widget _buildProductSize({String? name}) {
    return Container(
      height: 60,
      width: 60,
      color: Colors.grey[200],
      child: Center(
        child: Text(
          name!,
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }

  Widget _buildProductColor({Color? color}) {
    return Container(height: 60, width: 60, color: color);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ProductScreenTopPart(
                image: widget.image,
                productId: widget.productId,
                price: widget.price,
              ),
              ProductScreenBottomPart(productId: widget.productId)
            ],
          ),
        ));
  }
}

class ProductScreenTopPart extends StatefulWidget {
  String? image;
  String? productId;
  String? price;

  ProductScreenTopPart({this.image, this.productId, this.price});
  @override
  _ProductScreenTopPartState createState() =>
      new _ProductScreenTopPartState(image, productId, price);
}

double baseHeight = 640.0;

double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}

List<String> sizeNumlist = [
  "7",
  "8",
  "9",
  "10",
];
List<Color> colors = [
  Color(0xFFF9362E),
  Color(0xFF003CFF),
  Color(0xFFFFB73A),
  Color(0xFF3AFFFF),
  Color(0xFF1AD12C),
  Color(0xFFD66400),
];

String desc =
    "The iPhone is a smartphone made by Apple that combines a computer, iPod, digital camera and cellular phone into one device with a touchscreen interface. The iPhone runs the iOS operating system, and in 2021 when the iPhone 13 was introduced, it offered up to 1 TB of storage and a 12-megapixel camera.";

class _ProductScreenTopPartState extends State<ProductScreenTopPart> {
  String? image;
  String? productId;
  String? price;

  Color mainColor = const Color.fromARGB(255, 255, 115, 0);

  _ProductScreenTopPartState(this.image, this.productId, this.price);

  @override
  Widget build(BuildContext context) {
    CarouselController controller = CarouselController();
    return Stack(
      children: [
        StreamBuilder<Object>(
            stream: FirebaseFirestore.instance
                .collection('Products')
                .doc(productId)
                .collection('image_urls')
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Text('No Image Available');
              }
              return CarouselSlider.builder(
                carouselController: controller,
                options: CarouselOptions(
                    viewportFraction: 1,
                    aspectRatio: 1.0,
                    enlargeCenterPage: false,
                    enableInfiniteScroll: true,
                    initialPage: 0,
                    autoPlay: false,
                    onPageChanged: (val, _) {
                      setState(() {
                        print("new index $val");
                        //   controller.jumpToPage(val);
                      });
                    }),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index, int pageViewIndex) {
                  return GestureDetector(
                    onTap: () {},
                    child: Stack(
                      children: [
                        Card(
                          margin: const EdgeInsets.symmetric(vertical: 0),
                          child: Container(
                            width: double.infinity,
                            height: 600,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data.docs[index]['url']),
                                    fit: BoxFit.fitWidth)),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  color: mainColor,
                  icon: Icon(
                    Icons.arrow_back,
                    size: screenAwareSize(20.0, context),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    size: screenAwareSize(20.0, context),
                    color: mainColor,
                  ),
                  onPressed: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: Login(),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.slideUp,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class ProductScreenBottomPart extends StatefulWidget {
  String? productId;

  ProductScreenBottomPart({this.productId});
  @override
  _ProductScreenBottomPartState createState() =>
      new _ProductScreenBottomPartState(this.productId);
}

class _ProductScreenBottomPartState extends State<ProductScreenBottomPart> {
  bool isExpanded = false;
  int currentSizeIndex = 0;
  int currentColorIndex = 0;
  int _counter = 0;

  String? productId;

  Color mainColor = const Color.fromARGB(255, 255, 115, 0);

  _ProductScreenBottomPartState(this.productId);

  void _expand() {
    setState(() {
      isExpanded ? isExpanded = false : isExpanded = true;
    });
  }

  _buildPrice(String price) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'PRICE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(width: 5.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  '\JOD ${price}',
                  style: TextStyle(
                    color: mainColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String phoneNumber) {
    return Container(
      width: double.infinity,
      height: screenAwareSize(120.0, context),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: screenAwareSize(22.0, context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: screenAwareSize(10.0, context),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: MaterialButton(
                      color: const Color.fromARGB(255, 255, 115, 0),
                      padding: EdgeInsets.symmetric(
                        vertical: screenAwareSize(14.0, context),
                      ),
                      onPressed: () {
                        launchUrl(Uri.parse('tel://$phoneNumber'));
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: screenAwareSize(0.0, context)),
                          child: Text("Call Advertiser",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenAwareSize(15.0, context))),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(String feature, String firebaseFeature) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(feature,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: "Montserrat-SemiBold")),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  firebaseFeature,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontFamily: "Montserrat-Medium"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: StreamBuilder<Object>(
          stream: FirebaseFirestore.instance
              .collection('Products')
              .doc(productId)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            var product = snapshot.data;
            return StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(product['userId'])
                    .snapshots(),
                builder: (context, AsyncSnapshot userSnapshot) {
                  if (!userSnapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  var user = userSnapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildPrice(product['price'].toString()),
                      _buildFeature('Product', product['name']),
                      _buildFeature('Product Owner',
                          user['firstName'] + ' ' + user['lastName']),
                      _buildFeature('Product Category', product['subCategory']),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Product Description",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: "Montserrat-SemiBold"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: AnimatedCrossFade(
                                  firstChild: Text(
                                    product['description'],
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontFamily: "Montserrat-Medium"),
                                  ),
                                  secondChild: Text(
                                    product['description'],
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            screenAwareSize(10.0, context),
                                        fontFamily: "Montserrat-Medium"),
                                  ),
                                  crossFadeState: isExpanded
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                                  duration: kThemeAnimationDuration,
                                ),
                              ),
                            ),
                            GestureDetector(
                                onTap: _expand,
                                child: product['description'].length > 100
                                    ? Text(isExpanded ? "less" : "more..",
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 255, 115, 0)))
                                    : Container()),
                          ],
                        ),
                      ),
                      _buildFeature('Color', product['color']),
                      _buildButton(user['phoneNumber'])
                    ],
                  );
                });
          }),
    );
  }
}
