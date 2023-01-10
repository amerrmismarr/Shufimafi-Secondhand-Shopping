import 'package:dolabi/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';

class ProductColors extends StatefulWidget {
  const ProductColors({Key? key}) : super(key: key);

  @override
  State<ProductColors> createState() => _ProductColorsState();
}

class _ProductColorsState extends State<ProductColors> {
  Widget _buildColor(Color color, String colorName) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, colorName);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            GridTile(
                child: CircleAvatar(
              backgroundColor: color,
            )),
            SizedBox(
              height: 5,
            ),
            Text(
              colorName,
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'Select Color',
            style: TextStyle(color: mainColor),
          ),
          iconTheme: IconThemeData(color: mainColor),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 4,
          children: [
            _buildColor(Colors.orange, 'Orange'),
            _buildColor(Colors.green, 'Green'),
            _buildColor(Colors.blue, 'Blue'),
            _buildColor(Colors.pink, 'Pink'),
            _buildColor(Colors.black, 'Black'),
            _buildColor(Colors.purple, 'Purple'),
            Shimmer.fromColors(
                period: Duration(seconds: 3),
                baseColor: Colors.brown,
                highlightColor: Colors.white,
                child: _buildColor(Colors.brown, 'Bronze')),
            _buildColor(Colors.indigo, 'Indigo'),
            _buildColor(Colors.red, 'Red'),
            Shimmer.fromColors(
                period: Duration(seconds: 3),
                baseColor: Colors.amber,
                highlightColor: Colors.white,
                child: _buildColor(Colors.amber, 'Golden')),
            _buildColor(Color.fromARGB(255, 252, 206, 164), 'Beige'),
            _buildColor(Color.fromARGB(255, 51, 51, 51), 'Charcoal'),
            _buildColor(Color.fromARGB(255, 45, 85, 0), 'Olive'),
            _buildColor(Color.fromARGB(255, 236, 182, 2), 'Mustard'),
            _buildColor(Color.fromARGB(255, 168, 39, 0), 'Rust'),
            _buildColor(Color.fromARGB(255, 252, 241, 183), 'Cream'),
            _buildColor(Color.fromARGB(255, 0, 19, 124), 'Navy Blue'),
            _buildColor(Color.fromARGB(255, 253, 153, 228), 'Lavender'),
            _buildColor(Color.fromARGB(255, 255, 108, 63), 'Coral'),
            Shimmer.fromColors(
                period: Duration(seconds: 3),
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                child: _buildColor(Colors.grey, 'Silver')),
            _buildColor(Colors.brown, 'Brown'),
          ],
        ));
  }
}
