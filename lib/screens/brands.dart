import 'package:flutter/material.dart';

class Brands extends StatefulWidget {
  @override
  State<Brands> createState() => _BrandsState();
}

class _BrandsState extends State<Brands> {
  Color mainColor = const Color.fromARGB(255, 255, 115, 0);

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

  @override
  Widget build(BuildContext context) {
    brands.sort();
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
