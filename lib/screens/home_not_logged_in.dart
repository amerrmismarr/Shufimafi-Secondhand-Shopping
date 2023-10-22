import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dolabi/screens/login.dart';
import 'package:dolabi/screens/product_details_not_logged_in.dart';
import 'package:dolabi/screens/search_with_filter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeNotLoggedIn extends StatefulWidget {
  ScrollController? scrollController;
  HomeNotLoggedIn({this.scrollController});

  @override
  State<HomeNotLoggedIn> createState() =>
      _HomeNotLoggedInState(scrollController);
}

class _HomeNotLoggedInState extends State<HomeNotLoggedIn> {
  ScrollController? scrollController;
  _HomeNotLoggedInState(this.scrollController);
  Color mainColor = const Color.fromARGB(255, 255, 115, 0);
  String searchingText = 'Search.......';

  Widget _createFavoriteButton(String productId, IconData icon) {
    return IconButton(
      icon: Icon(icon, size: screenAwareSize(20.0, context), color: mainColor),
      onPressed: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: Login(),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.slideUp,
        );
      },
    );
  }

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
                      image: DecorationImage(image: NetworkImage(image))),
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
                      Text(
                        'JOD' + ' ' + price.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.grey),
                      ),
                      Text(
                        name,
                        style: TextStyle(fontSize: 13, color: Colors.black),
                      )
                    ],
                  ),
                  favorites.contains(productId)
                      ? _createFavoriteButton(productId, Icons.favorite)
                      : _createFavoriteButton(productId, Icons.favorite_border),
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
          screen: SearchWithFilter(
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

  Widget _buildCarousel() {
    CarouselController controller = CarouselController();
    return CarouselSlider.builder(
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
                      ? GestureDetector(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: Login(),
                              withNavBar: false,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.slideUp,
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: screenAwareSize(100, context),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/advertise.png'),
                                    fit: BoxFit.fitHeight)),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: Login(),
                              withNavBar: false,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.slideUp,
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: screenAwareSize(100, context),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/donate.png'),
                                    fit: BoxFit.fitHeight)),
                          ),
                        ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListView(
        controller: scrollController,
        children: <Widget>[
          _buildCarousel(),
          Container(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(
                  'Quick search',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            child:
                ListView(scrollDirection: Axis.horizontal, children: <Widget>[
              _buildCategory('dress_icon.png', 'Women', Colors.white),
              _buildCategory('shoes_icon.png', 'Kids', Colors.white),
              _buildCategory('tie_icon.png', 'Men', Colors.white),
              _buildCategory('cats_and_dogs_icon.png', 'Pets', Colors.white),
              _buildCategory('books_icon.png', 'Books', Colors.white),
              _buildCategory('household_icon.png', 'Household', Colors.white),
              _buildCategory(
                  'electronics_icon.png', 'Electronics', Colors.white),
            ]),
          ),
          Container(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(
                  'Newest products',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Products').snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              var products = snapshot.data.docs;
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.64,
                    crossAxisSpacing: 3,
                    crossAxisCount: 2),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              duration: Duration(milliseconds: 1000),
                              type: PageTransitionType.fade,
                              child: ProductDetailsNotLoggedIn(
                                  image: products[index]['image'],
                                  name: products[index]['name'],
                                  price: '1999',
                                  productId: products[index]['productId'])));
                    },
                    child: _buildFeaturedProduct(
                        products[index]['brand'],
                        '1000',
                        products[index]['image'],
                        products[index]['productId'], []),
                  );
                },
              );
            },
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
