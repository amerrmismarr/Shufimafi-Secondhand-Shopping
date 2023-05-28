import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dolabi/screens/home.dart';
import 'package:dolabi/screens/tabs_with_screens.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetails extends StatefulWidget {
  String? image;
  String? name;
  String? price;
  String? productId;
  String? category;
  String? brand;

  ProductDetails(
      {this.image,
      this.name,
      this.price,
      this.productId,
      this.category,
      this.brand});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
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

  ProductScreenTopPart({this.image, this.productId});
  @override
  _ProductScreenTopPartState createState() =>
      new _ProductScreenTopPartState(image, productId);
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

  _ProductScreenTopPartState(this.image, this.productId);

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
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 0),
                      child: Container(
                        width: double.infinity,
                        height: screenAwareSize(245, context),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    snapshot.data.docs[index]['url']),
                                fit: BoxFit.fitWidth)),
                      ),
                    ),
                  );
                },
              );
            }),
        Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  color: Colors.white,
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
                    color: Colors.white,
                  ),
                  onPressed: () {},
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

  _ProductScreenBottomPartState(this.productId);

  void _expand() {
    setState(() {
      isExpanded ? isExpanded = false : isExpanded = true;
    });
  }

  Widget _buildButton() {
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
                        launchUrl(Uri.parse('tel://0799512013'));
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                                  fontSize: screenAwareSize(10.0, context),
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
                _buildFeature('Size', 'Size'),
                _buildFeature('Color', product['color']),
                _buildFeature('Price', product['price']),
                _buildButton()
              ],
            );
          }),
    );
  }
}
