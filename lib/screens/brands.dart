import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Brands extends StatefulWidget {
  @override
  State<Brands> createState() => _BrandsState();
}

class _BrandsState extends State<Brands> {
  Widget _createListTile(String brand) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, brand);
      },
      child: ListTile(
        title: Text(
          brand,
          style: TextStyle(fontSize: 13),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 15,
          color: mainColor,
        ),
      ),
    );
  }

  Color mainColor = const Color.fromARGB(255, 255, 115, 0);

  List<String> brands = [
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

  String? condition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: Colors.white,
        title: Text(
          'Select Brand',
          style: TextStyle(color: mainColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
          itemCount: brands.length,
          itemBuilder: (context, index) {
            return _createListTile(brands[index]);
          }),
    );
  }
}
