import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dolabi/screens/product_details.dart';
import 'package:dolabi/screens/search_with_filter.dart';
import 'package:dolabi/screens/tabs_with_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../services/auth_bloc.dart';
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
    'Nike',
    'Louis Vuitton',
    'Hermes',
    'Gucci',
    'Zalando',
    'Adidas',
    'Tiffany & Co.',
    'H&M',
    'Cartier',
    'Lululemon',
    'Moncler',
    'Chanel',
    'Rolex',
    'Patek Philippe',
    'Prada',
    'Uniqlo',
    'Chow Tai Fook',
    'Swarovski',
    'Burberry',
    'Polo Ralph Lauren',
    'Tom Ford',
    'The North Face',
    'Levi\'s',
    'Victoria\'s Secret',
    'Next',
    'New Balance',
    'Michael Kors',
    'Skechers',
    'TJ Maxx',
    'ASOS',
    'Under Armour',
    'Coach',
    'Nordstrom',
    'C&A',
    'Chopard',
    'Dolce & Gabbana',
    'Christian Louboutin',
    'Omega',
    'Foot Locker Inc.',
    'Ray Ban',
    'Macy\'s',
    'Asics',
    'Vera Wang',
    'Dior',
    'Puma',
    'Steve Madden',
    'Brunello Cucinelli',
    'American Eagle Outfitters',
    'Armani',
    'Nine West',
    'Fendi',
    'Urban Outfitters',
    'Salvatore Ferragamo',
    'Hugo Boss',
    'Old Navy',
    'IWC Schaffhausen',
    'Primark',
    'Max Mara',
    'Manolo Blahnik',
    'Audemars Piguet',
    'Diesel',
    'Calvin Klein',
    'Net-a-Porter',
    'Furla',
    'GAP',
    'Longines',
    'Forever 21',
    'Stuart Weitzman',
    'Longchamp',
    'Sisley',
    'Lao Feng Xiang',
    'TOD\'s',
    'Tissot',
    'Tommy Hilfiger',
    'Tory Burch',
    'Lacoste',
    'Topshop',
    'G-star',
    'Oakley',
    'Cole Haan',
    'Jimmy Choo',
    'Valentino',
    'Elie Taharie',
    'Jaeger-Le Coultre',
    'Fossil',
    'Vacheron Constantin',
    'Elie Saab',
    'Patagonia',
    'Bogner',
    'New Look',
    'Breguet',
    'ESCADA',
    'Tag Heuer',
    'Banana Republic',
    'Desigual',
    'Swatch',
    'Cavalli',
    'Ted Baker'
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

  Widget _buildBrand(String image, String searchText, Color color) {
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
                image: DecorationImage(
                    image: AssetImage('images/$image'), fit: BoxFit.fill)),
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
    var authBloc = Provider.of<AuthBloc>(context);
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
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          _buildCategory(
                              'dress_icon.png', 'Women', Colors.white),
                          _buildCategory(
                              'shoes_icon.png', 'Kids', Colors.white),
                          _buildCategory('tie_icon.png', 'Men', Colors.white),
                          _buildCategory(
                              'cats_and_dogs_icon.png', 'Pets', Colors.white),
                          _buildCategory(
                              'books_icon.png', 'Books', Colors.white),
                          _buildCategory(
                              'household_icon.png', 'Household', Colors.white),
                          _buildCategory('electronics_icon.png', 'Electronics',
                              Colors.white),
                        ]),
                  ),
                )
              : CustomSliver(child: SizedBox(height: 30)),
          searchingText == ' ' || searchingText == null || searchingText == ''
              ? CustomSliver(
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text(
                              'Special brands for you',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : CustomSliver(child: SizedBox(height: 30)),
          searchingText == ' ' || searchingText == null || searchingText == ''
              ? CustomSliver(
                  child: Container(
                    height: 60,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          _buildBrand('adidas.jpg', 'Adidas', Colors.white),
                          _buildBrand('zara.jpg', 'Zara', Colors.white),
                          _buildBrand('koton.png', 'Koton', Colors.white),
                          _buildBrand('massimu_dutti.jpg', 'Massimu Dutti',
                              Colors.white),
                          _buildBrand(
                              'lc_wakiki.jpeg', 'LC Wakiki', Colors.white),
                          _buildBrand('mango.jpg', 'Mango', Colors.white),
                          _buildBrand('apple.jpg', 'Apple', Colors.white),
                          _buildBrand(
                              'pull&bear.jpg', 'Pull&Bear', Colors.white),
                          _buildBrand('h&m.png', 'H&M', Colors.white),
                          _buildBrand('tommy_hilfiger.jpg', 'Tommy Hilfiger',
                              Colors.white),
                          _buildBrand('penti.png', 'Penti', Colors.white),
                          _buildBrand('uspolo.png', 'US Polo', Colors.white),
                          _buildBrand('nike.jpg', 'Nike', Colors.white),
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
