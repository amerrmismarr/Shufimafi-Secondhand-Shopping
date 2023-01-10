import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dolabi/screens/home.dart';
import 'package:dolabi/screens/tabs_with_screens.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductDetails extends StatefulWidget {
  String? image;
  String? name;
  String? price;
  String? productId;

  ProductDetails({this.image, this.name, this.price, this.productId});

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
                return Text('fuck');
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
                SizedBox(
                  height: screenAwareSize(8.0, context),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: screenAwareSize(16.0, context)),
                  child: Text(
                    "Product Description",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: screenAwareSize(15.0, context),
                        fontFamily: "Montserrat-SemiBold"),
                  ),
                ),
                SizedBox(
                  height: screenAwareSize(8.0, context),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenAwareSize(26.0, context),
                      right: screenAwareSize(18.0, context)),
                  child: AnimatedCrossFade(
                    firstChild: Text(
                      product['description'],
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenAwareSize(10.0, context),
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
                Padding(
                  padding: EdgeInsets.only(
                      left: screenAwareSize(26.0, context),
                      right: screenAwareSize(18.0, context)),
                  child: GestureDetector(
                      onTap: _expand,
                      child: product['description'].length > 100
                          ? Text(isExpanded ? "less" : "more..",
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 255, 115, 0)))
                          : Container()),
                ),
                SizedBox(
                  height: screenAwareSize(12.0, context),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenAwareSize(15.0, context),
                      right: screenAwareSize(75.0, context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Size",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenAwareSize(15.0, context),
                              fontFamily: "Montserrat-SemiBold")),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenAwareSize(26.0, context),
                      right: screenAwareSize(18.0, context)),
                  child: Text(
                    'Size',
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: screenAwareSize(10.0, context),
                        fontFamily: "Montserrat-Medium"),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenAwareSize(15.0, context),
                      right: screenAwareSize(75.0, context)),
                  child: Text("Color",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: screenAwareSize(15.0, context),
                          fontFamily: "Montserrat-SemiBold")),
                ),
                SizedBox(
                  height: screenAwareSize(8.0, context),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenAwareSize(26.0, context),
                      right: screenAwareSize(18.0, context)),
                  child: Text(
                    product['color'],
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: screenAwareSize(10.0, context),
                        fontFamily: "Montserrat-Medium"),
                  ),
                ),
                SizedBox(
                  height: screenAwareSize(8.0, context),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenAwareSize(15.0, context),
                      right: screenAwareSize(75.0, context)),
                  child: Text("Price",
                      style: TextStyle(
                          fontSize: screenAwareSize(15, context),
                          color: Colors.black,
                          fontFamily: "Montserrat-SemiBold")),
                ),
                SizedBox(
                  height: screenAwareSize(8.0, context),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenAwareSize(26.0, context),
                      right: screenAwareSize(18.0, context)),
                  child: Text(
                    'JOD' + ' ' + product['price'],
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: screenAwareSize(10.0, context),
                        fontFamily: "Montserrat-Medium"),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: screenAwareSize(120.0, context),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            left: screenAwareSize(22.0, context)),
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
                                  onPressed: () {},
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: screenAwareSize(0.0, context)),
                                      child: Text("Call Advertiser",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: screenAwareSize(
                                                  15.0, context))),
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
                )
              ],
            );
          }),
    );
  }
}

Widget sizeItem(String size, bool isSelected, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 12.0),
    child: Container(
      width: screenAwareSize(30.0, context),
      height: screenAwareSize(30.0, context),
      decoration: BoxDecoration(
          color: isSelected ? Color(0xFFFC3930) : Color(0xFF525663),
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
                color:
                    isSelected ? Colors.black.withOpacity(.5) : Colors.black12,
                offset: Offset(0.0, 10.0),
                blurRadius: 10.0)
          ]),
      child: Center(
        child: Text(size,
            style:
                TextStyle(color: Colors.white, fontFamily: "Montserrat-Bold")),
      ),
    ),
  );
}

Widget colorItem(
    Color color, bool isSelected, BuildContext context, VoidCallback _ontab) {
  return GestureDetector(
    onTap: _ontab,
    child: Padding(
      padding: EdgeInsets.only(left: screenAwareSize(10.0, context)),
      child: Container(
        width: screenAwareSize(30.0, context),
        height: screenAwareSize(30.0, context),
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                        color: Colors.black.withOpacity(.8),
                        blurRadius: 10.0,
                        offset: Offset(0.0, 10.0))
                  ]
                : []),
        child: ClipPath(
          clipper: MClipper(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: color,
          ),
        ),
      ),
    ),
  );
}

class MClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width * 0.2, size.height);
    path.lineTo(size.width, size.height * 0.2);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

Widget divider() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    child: Container(
      width: 0.8,
      color: Colors.black,
    ),
  );
}
