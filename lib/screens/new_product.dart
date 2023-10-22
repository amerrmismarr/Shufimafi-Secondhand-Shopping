import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_group_list/custom_radio_group_list.dart';
import 'package:dolabi/main.dart';
import 'package:dolabi/screens/brands.dart';
import 'package:dolabi/screens/bullet_widget.dart';
import 'package:dolabi/screens/categories.dart';
import 'package:dolabi/screens/colors.dart';
import 'package:dolabi/screens/condition.dart';
import 'package:dolabi/screens/tabs_with_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart' as path;
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:uuid/uuid.dart';

class NewProduct extends StatefulWidget {
  @override
  _NewProductState createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  String mainCategory = ' ';
  String middleCategory = ' ';
  String subCategory = ' ';
  String condition = 'Used';
  String brand = ' ';
  String color = ' ';

  Color mainColor = const Color.fromARGB(255, 255, 115, 0);

  String name = ' ';
  String price = ' ';
  String description = ' ';
  String originalPrice = ' ';
  String? token;

  bool _switchValue = true;

  List<XFile> _images = [];
  final picker = ImagePicker();
  List<String> _arrImageUrls = [];

  FirebaseStorage _storageRef = FirebaseStorage.instance;
  CollectionReference? imgRef;
  CollectionReference? dataRef;
  Reference? ref;

  bool checkedvalue = false;

  var uuid = Uuid();

  List<String> conditions = [
    'Used',
    'Used but in good condition',
    'Price Tag on'
  ];

  int selectedImagesLength = 0;

  Future<void> _navigateAndReturnCategory(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Categories()),
    );

    if (!mounted) return;

    setState(() {
      if (result != null) {
        mainCategory = result[0];
        middleCategory = result[1];
        subCategory = result[2];
      }
    });
  }

  Future<void> _navigateAndReturnCondition(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Condition()),
    );

    if (!mounted) return;

    setState(() {
      if (result != null) {
        condition = result;
      }
    });
  }

  Future<void> _navigateAndReturnBrand(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Brands()),
    );

    if (!mounted) return;

    setState(() {
      if (result != null) {
        brand = result;
      }
    });
  }

  Future<void> _navigateAndReturnColor(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductColors()),
    );

    if (!mounted) return;

    setState(() {
      if (result != null) {
        color = result;
      }
    });
  }

  _createAlertDialog(String error) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                error,
                style: TextStyle(color: mainColor),
              ),
              icon: Icon(
                Icons.error,
                color: mainColor,
              ),
            ));
  }

  chooseImage() async {
    final List<XFile>? selectedImages = await picker.pickMultiImage();
    setState(() {
      if (selectedImages != null && selectedImages.length < 6) {
        _images.addAll(selectedImages);

        print(selectedImages.length.toString());
      } else if (selectedImages != null && selectedImages.length >= 6) {
        _createAlertDialog('The maximum number of images is 5');
      } else {
        print('no images');
      }
    });

    // if (pickedFile == null) retrieveLostData();
  }

  /*Future uploadFile() async {
    imgRef = FirebaseFirestore.instance
        .collection('Products')
        .doc(title)
        .collection('image_urls');
    for (var img in _images) {
      ref = storage.ref().child('products/${path.basename(img.path)}');

      await ref!.putFile(img).whenComplete(() async {
        await ref!.getDownloadURL().then((value) {
          imgRef!.add({'url': value, 'title': title, 'price': price});
          // dataRef!.add({'title': title, 'description': description});
          fireStoreService.saveProduct(
              title,
              price,
              'https://firebasestorage.googleapis.com/v0/b/dolabi-61032.appspot.com/o/products%2Fimage_picker7825635887174782008.jpg?alt=media&token=439eeaef-f684-4f9c-9aaa-738e9da2f192',
              []);
        });
      });
    }
  }*/

  Future<List<String>> uploadFiles(List<XFile> _images) async {
    var imageUrls =
        await Future.wait(_images.map((_image) => uploadFile(_image)));
    print(imageUrls);
    return imageUrls;
  }

  Future<String> uploadFile(XFile _image) async {
    imgRef = FirebaseFirestore.instance
        .collection('Products')
        .doc()
        .collection('image_urls');

    Reference storageReference =
        FirebaseStorage.instance.ref().child('posts/${_image.path}');
    UploadTask uploadTask = storageReference.putFile(File(_image.path));
    await uploadTask;

    return await storageReference.getDownloadURL();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(condition);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                Icons.close,
                color: mainColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
          elevation: 0.0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Product Information',
            style: TextStyle(color: mainColor),
          ),
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              token = snapshot.data!['Token'];
              print(token);
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 100,
                              child: Stack(
                                children: [
                                  ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _images.length + 1,
                                    itemBuilder: (context, index) {
                                      return index == 0
                                          ? Container(
                                              width: 100,
                                              height: 100,
                                              margin: EdgeInsets.all(3),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.image,
                                                      color: mainColor,
                                                    ),
                                                    onPressed: () {
                                                      chooseImage();
                                                    },
                                                  ),
                                                  Text('Add Images'),
                                                  Text(_images.length
                                                          .toString() +
                                                      '/' +
                                                      '5'),
                                                ],
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Stack(
                                                alignment: Alignment.topRight,
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    height: 100,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Image.file(
                                                          File(
                                                              _images[index - 1]
                                                                  .path),
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        _images.remove(
                                                            _images[index - 1]);

                                                        print(_images.length);
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Center(
                                                          child: Icon(
                                                        Icons
                                                            .remove_circle_sharp,
                                                        color: mainColor,
                                                      )),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.grey[200],
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Name of the product',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(onChanged: (text) {
                                name = text;
                              }),
                            ),
                            Container(
                              color: Colors.grey[200],
                              height: 50,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Talk about the product',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                  maxLines: 3,
                                  onChanged: (text) {
                                    description = text;
                                  }),
                            ),
                            Container(
                              color: Colors.grey[200],
                              height: 50,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Details',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                _navigateAndReturnCategory(context);
                              },
                              child: ListTile(
                                title: Text(
                                  'Category',
                                  style: TextStyle(fontSize: 13),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                  color: mainColor,
                                ),
                                subtitle: Text(
                                  mainCategory == ' ' ||
                                          middleCategory == ' ' ||
                                          subCategory == ' '
                                      ? ' '
                                      : mainCategory == 'Pets'
                                          ? mainCategory +
                                              ' | ' +
                                              middleCategory +
                                              ' | ' +
                                              subCategory
                                          : mainCategory +
                                              ' | ' +
                                              middleCategory +
                                              ' | ' +
                                              subCategory,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     _navigateAndReturnBrand(context);
                            //   },
                            //   child: ListTile(
                            //     title: Text(
                            //       'Brand',
                            //       style: TextStyle(fontSize: 13),
                            //     ),
                            //     trailing: Icon(
                            //       Icons.arrow_forward_ios,
                            //       size: 15,
                            //       color: mainColor,
                            //     ),
                            //     subtitle: Text(
                            //       brand,
                            //       style: TextStyle(fontSize: 13),
                            //     ),
                            //   ),
                            // ),

                            // Divider(
                            //   thickness: 2,
                            // ),
                            mainCategory == 'Women' || mainCategory == 'Men'
                                ? GestureDetector(
                                    onTap: () {
                                      _navigateAndReturnColor(context);
                                    },
                                    child: ListTile(
                                      title: Text(
                                        'Color',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                        color: mainColor,
                                      ),
                                      subtitle: Text(
                                        color,
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  )
                                : Container(),
                            mainCategory == 'Women' || mainCategory == 'Men'
                                ? Divider(
                                    thickness: 2,
                                  )
                                : Container(),
                            Container(
                              color: Colors.grey[200],
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Brand',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(onChanged: (text) {
                                brand = text;
                              }),
                            ),
                            Container(
                              color: Colors.grey[200],
                              height: 50,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Condition',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  )),
                            ),
                            RadioGroup(
                                selectedItem: 0,
                                scrollDirection: Axis.vertical,
                                textSize: 13,
                                radioList: conditions,
                                onChanged: (value) {
                                  setState(() {
                                    condition = value;
                                  });
                                }),
                            Container(
                              color: Colors.grey[200],
                              height: 50,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Price',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  )),
                            ),
                            ListTile(
                                title: Text(
                                  'Original price of the item',
                                  style: TextStyle(fontSize: 13),
                                ),
                                trailing: SizedBox(
                                    width: 50,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      onChanged: (text) {
                                        originalPrice = text;
                                      },
                                      decoration: InputDecoration(
                                        hintText: '0 JOD',
                                        hintStyle: TextStyle(fontSize: 13),
                                      ),
                                    ))),
                            ListTile(
                                title: Text(
                                  'For how much do you want to sell it?',
                                  style: TextStyle(fontSize: 13),
                                ),
                                trailing: SizedBox(
                                    width: 50,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      onChanged: (text) {
                                        price = text;
                                      },
                                      decoration: InputDecoration(
                                        hintText: '0 JOD',
                                        hintStyle: TextStyle(fontSize: 13),
                                      ),
                                    ))),
                            SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      //padding: EdgeInsets.only(left: 30, right: 30),
                      height: 50,
                      width: 500,
                      child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(mainColor)),
                          onPressed: () async {
                            var productId = uuid.v1();
                            if (_images.length == 0) {
                              _createAlertDialog(
                                  'Please choose at least one image');
                            } else if (name.trim() == null ||
                                name.trim() == '' ||
                                name.trim() == ' ') {
                              _createAlertDialog(
                                  'Please fill in the name of the product');
                            } else if (description.trim() == null ||
                                description.trim() == '' ||
                                description.trim() == ' ') {
                              _createAlertDialog('Please describe the product');
                            } else if (mainCategory.trim() == null ||
                                mainCategory.trim() == '' ||
                                middleCategory.trim() == ' ' ||
                                middleCategory.trim() == null ||
                                middleCategory.trim() == '' ||
                                middleCategory.trim() == ' ' ||
                                subCategory.trim() == null ||
                                subCategory.trim() == '' ||
                                subCategory.trim() == ' ') {
                              _createAlertDialog('Please choose a Category');
                            } else if (brand.trim() == null ||
                                brand.trim() == '' ||
                                brand.trim() == ' ') {
                              _createAlertDialog(
                                  'Please choose a brand for the product');
                            } else if (color.trim() == null ||
                                color.trim() == '' ||
                                color.trim() == ' ') {
                              _createAlertDialog('Please choose a color');
                            } else if (originalPrice.trim() == null ||
                                originalPrice.trim() == '' ||
                                originalPrice.trim() == ' ') {
                              _createAlertDialog(
                                  'Please fill in the original price of the product');
                            } else if (price.trim() == null ||
                                price.trim() == '' ||
                                price.trim() == ' ') {
                              _createAlertDialog('Please fill in the price');
                            } else {
                              uploadFiles(_images).then((value) {
                                for (int i = 0; i < value.length; i++) {
                                  FirebaseFirestore.instance
                                      .collection('Products')
                                      .doc(productId)
                                      .collection('image_urls')
                                      .add({'url': value[i]});
                                }
                                FirebaseFirestore.instance
                                    .collection('Products')
                                    .doc(productId)
                                    .set({
                                  'name': name,
                                  'description': description,
                                  'mainCategory': mainCategory,
                                  'middleCategory': middleCategory,
                                  'subCategory': subCategory,
                                  'brand': brand,
                                  'condition': condition,
                                  'color': color,
                                  'price': price,
                                  'origianPrice': originalPrice,
                                  'productId': productId,
                                  'image': value[0],
                                  'userId':
                                      FirebaseAuth.instance.currentUser!.uid,
                                  'token': token
                                });
                              });

                              /* PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen: TabsWithScreens(),
                                          withNavBar: false,
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.slideUp,
                                        );*/
                            }
                          },
                          icon: const Icon(Icons.post_add),
                          label: const Text('Post Ad')),
                    ),
                  ),
                ],
              );
            }));
  }
}

class SampleData {
  String id;
  String data;

  SampleData({required this.id, required this.data});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['data'] = this.data;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
