import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dolabi/screens/login.dart';
import 'package:dolabi/screens/product_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  Color mainColor = const Color.fromARGB(255, 255, 115, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<User?>(
            initialData: FirebaseAuth.instance.currentUser,
            stream: FirebaseAuth.instance.userChanges(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return const FavoritesLoggedIn();
              }
              return const FavoritesNotLoggedIn();
            }));
  }
}

class FavoritesLoggedIn extends StatefulWidget {
  const FavoritesLoggedIn({super.key});

  @override
  State<FavoritesLoggedIn> createState() => _FavoritesLoggedInState();
}

class _FavoritesLoggedInState extends State<FavoritesLoggedIn> {
  Color mainColor = const Color.fromARGB(255, 255, 115, 0);

  Widget _buildFeaturedProduct(String name, String price, String image,
      String productId, List favorites) {
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
                          fit: BoxFit.cover, image: NetworkImage(image))),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Center(
            child: Text(
          'Favorites',
          style: TextStyle(color: mainColor),
        )),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                  height: 400,
                  width: 400,
                  child: Center(child: Text('no data')));
            }
            List favorites = snapshot.data!.get('favorites');
            favorites.add('not empty');
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Products')
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }
                        List products = snapshot.data.docs;
                        List favoriteProducts = [];
                        for (var product in products) {
                          for (var favorite in favorites) {
                            if (product['productId'] == favorite) {
                              favoriteProducts.add(product);
                            }
                          }
                        }
                        return GridView.builder(
                          shrinkWrap: true,
                          //     physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.64,
                                  crossAxisSpacing: 3,
                                  crossAxisCount: 2),
                          itemCount: favoriteProducts.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        duration: Duration(milliseconds: 1000),
                                        type: PageTransitionType.fade,
                                        child: ProductDetails()));
                              },
                              child: _buildFeaturedProduct(
                                  favoriteProducts[index]['brand'],
                                  favoriteProducts[index]['price'],
                                  favoriteProducts[index]['image'],
                                  favoriteProducts[index]['productId'],
                                  favorites),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class FavoritesNotLoggedIn extends StatefulWidget {
  const FavoritesNotLoggedIn({super.key});

  @override
  State<FavoritesNotLoggedIn> createState() => _FavoritesNotLoggedInState();
}

class _FavoritesNotLoggedInState extends State<FavoritesNotLoggedIn> {
  Color mainColor = const Color.fromARGB(255, 255, 115, 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Favorites',
          style: TextStyle(color: mainColor),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('images/logo.png')))),
            Center(
              child: Text('Please log in to view your favorites'),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                  onPressed: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: Login(),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.slideUp,
                    );
                  },
                  child: Text('Log in'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
