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

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String categoryName = ' ';
  String mainCategory = ' ';
  String subCategory = ' ';
  String condition = 'Condition';
  String brand = ' ';
  String color = ' ';

  Color mainColor = const Color.fromARGB(255, 255, 115, 0);

  late String name;
  late String price;
  late String description;
  late String originalPrice;
  late String token;

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

  Future<void> _navigateAndReturnCategory(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Categories()),
    );

    if (!mounted) return;

    setState(() {
      if (result != null) {
        mainCategory = result[0];
        subCategory = result[1];
        categoryName = result[2];
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

  chooseImage() async {
    final List<XFile>? selectedImages = await picker.pickMultiImage();
    setState(() {
      if (selectedImages != null) {
        _images.addAll(selectedImages);

        print(selectedImages.length.toString());
      } else {
        print('no  Image');
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

  void uploadFiles(List<XFile> images) {
    var productId = uuid.v1();
    for (int i = 0; i < images.length; i++) {
      uploadFile(_images[i], productId);
      // _arrImageUrls.add(imageUrl.toString());
    }
  }

  Future<String> uploadFile(XFile image, String productId) async {
    imgRef = FirebaseFirestore.instance
        .collection('Products')
        .doc(productId)
        .collection('image_urls');
    Reference reference =
        _storageRef.ref().child('multiple_images').child(image.name);
    UploadTask uploadTask = reference.putFile(File(image.path));
    await uploadTask.whenComplete(() async {
      await reference.getDownloadURL().then((value) {
        imgRef!.add({'url': value});
        print('value');
        // dataRef!.add({'title': title, 'description': description});
        FirebaseFirestore.instance.collection('Products').doc(productId).set({
          'name': name,
          'description': description,
          'category': categoryName,
          'brand': brand,
          'condition': condition,
          'color': color,
          'price': price,
          'origianPrice': originalPrice,
          'productId': productId,
          'image': value,
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'token': token
        });
      });
    });

    return await reference.getDownloadURL();
  }

  /*Future<void> retrieveLostData() async {
    final LostData response = await picker.();
    if (response.isEmpty) {
      return;
    }

    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close,
                  color: mainColor,
                ))
          ],
          elevation: 0.0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Filter',
            style: TextStyle(color: mainColor),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 10,
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
                        categoryName,
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      _navigateAndReturnBrand(context);
                    },
                    child: ListTile(
                      title: Text(
                        'Brand',
                        style: TextStyle(fontSize: 13),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: mainColor,
                      ),
                      subtitle: Text(
                        brand,
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  GestureDetector(
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
                  ),
                  Divider(
                    thickness: 2,
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
                      scrollDirection: Axis.vertical,
                      textSize: 13,
                      radioList: conditions,
                      textParameterName: 'data',
                      onChanged: (value) {
                        print('Value : ${value}');
                      }),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ],
        ));
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
