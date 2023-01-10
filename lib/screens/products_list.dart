import 'package:dolabi/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({Key? key}) : super(key: key);

  Widget _buildFeaturedProduct(String name, double price, String image) {
    return Card(
      child: Container(
        height: 250,
        width: 170,
        child: Column(
          children: <Widget>[
            Container(
              height: 190,
              width: 160,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage('images/$image'))),
            ),
            Text(
              'JOD' + ' ' + price.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.grey),
            ),
            Text(
              name,
              style: TextStyle(fontSize: 17, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Color.fromARGB(255, 177, 67, 114),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (cxt) => Home()));
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.notifications_none),
              onPressed: () {},
            ),
          ]),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        'Featured',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 650,
                  child: GridView.count(
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 2,
                    children: <Widget>[
                      _buildFeaturedProduct('Watch', 200.0, 'dress.jpg'),
                      _buildFeaturedProduct('Dress', 30.0, 'dress2.jpg'),
                      _buildFeaturedProduct('Watch', 200.0, 'shirt.jpg'),
                      _buildFeaturedProduct('Dress', 30.0, 'shoes.jpg'),
                      _buildFeaturedProduct('Watch', 200.0, 'watch.jpg'),
                      _buildFeaturedProduct('Dress', 30.0, 'tie.jpg'),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
