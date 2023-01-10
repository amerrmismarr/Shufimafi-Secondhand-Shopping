import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dolabi/screens/home_logged_in.dart';
import 'package:dolabi/screens/product_details.dart';
import 'package:dolabi/screens/search_with_filter.dart';
import 'package:dolabi/screens/tabs_with_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../models.dart/product.dart';
import 'login.dart';

class Search extends StatefulWidget {
  String? searchText;
  Search({this.searchText});

  @override
  State<Search> createState() => _SearchState(this.searchText);
}

class _SearchState extends State<Search> {
  String? searchText;
  _SearchState(this.searchText);
  Color mainColor = const Color.fromARGB(255, 255, 115, 0);

  String searchingText = ' ';

  TextEditingController _editingController = TextEditingController();

  List<String> searchList = [
    'Adidas',
    'Mango',
    'Massimu Dutti',
    'Zara',
    'Zara Men',
    'Zara Women',
    'Bershka',
    'Pull and Bear',
    'Bossini',
    'Springfield',
    'Pimkie',
    'Aldo',
    'G-2000',
    'G 2000',
    'G2000',
  ];

  List<String> filteredList = [];

  @override
  void initState() {
    if (searchText != null) {
      _editingController.text = searchText!;
      searchingText = searchText!;
    }
    super.initState();
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

  Widget _buildFeaturedProduct(String name, String price, String image,
      String productId, List favorites, String token, String userId) {
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
                          image: NetworkImage(image), fit: BoxFit.fitHeight)),
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
                        width: 90,
                        child: Text(
                          'JOD' + ' ' + price.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.grey),
                        ),
                      ),
                      Container(
                        width: 90,
                        child: Text(
                          name,
                          style: TextStyle(fontSize: 17, color: Colors.black),
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
                            if (FirebaseAuth.instance.currentUser != null) {
                              FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .set({
                                'favorites': FieldValue.arrayUnion([productId])
                              }, SetOptions(merge: true));
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Login()));
                            }

                            /*       sendNotification(
                                'Someone likes your product', token);
                            FirebaseFirestore.instance
                                .collection('Users')
                                .doc(userId)
                                .collection('Notifications')
                                .doc(notificationId)
                                .set({'title': 'Someone likes your product'});*/
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
    Color mainColor = const Color.fromARGB(255, 255, 115, 0);
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: const Color.fromARGB(255, 255, 115, 0),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Container(
              width: double.infinity,
              height: 40,
              child: Center(
                child: TextField(
                  onSubmitted: (value) {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: SearchWithFilter(
                        searchText: value,
                      ),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.slideUp,
                    );
                  },
                  controller: _editingController,
                  textAlignVertical: TextAlignVertical.bottom,
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      searchingText = value;
                      if (value != null || value != '') {
                        filteredList = searchList
                            .where((item) =>
                                item.toLowerCase().startsWith(searchingText))
                            .toList();
                      } else {
                        filteredList.clear();
                      }
                    });
                  },
                  decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 255, 115, 0)),
                      ),
                      prefixIcon: Icon(
                          color: const Color.fromARGB(255, 255, 115, 0),
                          Icons.search),
                      suffixIcon: IconButton(
                        color: const Color.fromARGB(255, 255, 115, 0),
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _editingController.clear();
                          setState(() {
                            searchingText = ' ';
                            filteredList.clear();
                          });
                        },
                      ),
                      hintText: 'Search by product, category, brand or color',
                      hintStyle: TextStyle(
                          color: const Color.fromARGB(255, 255, 115, 0))),
                ),
              ))),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: CustomScrollView(slivers: [
          searchingText == ' ' || searchingText == null || searchingText == ''
              ? CustomSliver(
                  child: Container(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          'Quick search',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              : CustomSliver(child: SizedBox(height: 30)),
          searchingText == ' ' || searchingText == null || searchingText == ''
              ? CustomSliver(
                  child: Container(
                    height: 60,
                    child:
                        ListView(scrollDirection: Axis.horizontal, children: <
                            Widget>[
                      _buildCategory('dress_icon.png', 'Perfume', Colors.white),
                      _buildCategory('shoes_icon.png', 'Orange', Colors.white),
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
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: SearchWithFilter(
                            searchText: filteredList[index],
                          ),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.slideUp,
                        );
                      },
                      child: ListTile(
                        title: Text(
                          filteredList[index],
                        ),
                      ),
                    );
                  },
                  childCount: filteredList.length,
                ))
        ]),
      ),
    );
  }
}

class CustomSliver extends SingleChildRenderObjectWidget {
  CustomSliver({Widget? child, Key? key}) : super(child: child, key: key);
  @override
  RenderObject createRenderObject(BuildContext context) {
    // ignore: todo
    // TODO: implement createRenderObject
    return RenderSliverTableCalendar();
  }
}

class RenderSliverTableCalendar extends RenderSliverSingleBoxAdapter {
  RenderSliverTableCalendar({
    RenderBox? child,
  }) : super(child: child);

  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }
    final SliverConstraints constraints = this.constraints;
    child!.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    double childExtent;
    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = child!.size.width;
        break;
      case Axis.vertical:
        childExtent = child!.size.height;
        break;
    }
    assert(childExtent != null);
    final double paintedChildSize =
        calculatePaintOffset(constraints, from: 0.0, to: childExtent);
    final double cacheExtent =
        calculateCacheOffset(constraints, from: 0.0, to: childExtent);

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    geometry = SliverGeometry(
      scrollExtent: childExtent,
      paintExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxPaintExtent: childExtent,
      hitTestExtent: paintedChildSize,
      hasVisualOverflow: childExtent > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
    );
    setChildParentData(child!, constraints, geometry!);
    // ignore: todo
    // TODO: implement performLayout
  }
}
