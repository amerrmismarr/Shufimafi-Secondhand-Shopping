import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dolabi/models.dart/product.dart';
import 'package:dolabi/screens/cart.dart';
import 'package:dolabi/screens/new_product.dart';
import 'package:dolabi/screens/product_details.dart';
import 'package:dolabi/screens/products_list.dart';
import 'package:dolabi/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:vertical_tabs_flutter/vertical_tabs.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool homeColor = false;
  bool cartColor = false;
  bool aboutColor = false;
  bool contactUsColor = false;

  bool _expanded = false;
  bool _expanded2 = false;
  bool _expanded3 = false;
  bool _expanded4 = false;
  bool _expanded5 = false;
  bool _expanded6 = false;
  bool _expanded7 = false;

  String searchText = 'Search';

  Color mainColor = const Color.fromARGB(255, 255, 115, 0);

  Widget _buildExpansionPanelImage(String image) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/${image}'))),
    );
  }

  Widget _buildGridTile(String mainCategory, String middleCategory,
      String subCategory, String image) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, [mainCategory, middleCategory, subCategory]);
      },
      child: GridTile(
          footer: Center(
            child: Text(
              subCategory,
              style: TextStyle(fontSize: 10),
            ),
          ),
          child: _buildExpansionPanelImage(image)),
    );
  }

  ExpansionPanel _buildExpansionPanelBagsWomen(String title, bool expanded) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
        );
      },
      body: Column(
        children: [
          GridView.count(
            childAspectRatio: 1.2,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              _buildGridTile(
                  'Women', title, 'Shoulder Bags', 'shoulder_bag.jpg'),
              _buildGridTile('Women', title, 'Clutches', 'clutch.jpg'),
              _buildGridTile('Women', title, 'Purses', 'purse.jpg'),
              _buildGridTile('Women', title, 'Crossbody', 'crossbody.jpg'),
              _buildGridTile('Women', title, 'Backpacks', 'backpack.jpg'),
              _buildGridTile('Women', title, 'Fanny packs', 'fannypack.jpg'),
              _buildGridTile('Women', title, 'Tote Bags', 'tote_bag.jpg'),
              _buildGridTile('Women', title, 'Satchels', 'satchel.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelBagsMen(String title, bool expanded) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
        );
      },
      body: Column(
        children: [
          GridView.count(
            childAspectRatio: 1.2,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              _buildGridTile(
                  'Men', title, 'Clutches&Wallets', 'clutches_wallets_men.jpg'),
              _buildGridTile(
                  'Men', title, 'Fanny Packs', 'fanny_packs_men.jpg'),
              _buildGridTile(
                  'Men', title, 'Crossbody Bags', 'crossbody_bags_men.jpg'),
              _buildGridTile('Men', title, 'Backpacks', 'backpacks_men.jpg'),
              _buildGridTile('Men', title, 'Tote Bags', 'tote_bags_men.jpg'),
              _buildGridTile('Men', title, 'Briefcases', 'briefcases_men.jpg'),
              _buildGridTile('Men', title, 'Bag Sets', 'bag_sets_men.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelClothesWomen(String title, bool expanded) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
        );
      },
      body: Column(
        children: [
          GridView.count(
            childAspectRatio: 1.2,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              _buildGridTile('Women', title, 'Tops', 'tops_women.jpg'),
              _buildGridTile('Women', title, 'Bottoms', 'bottoms_women.jpg'),
              _buildGridTile('Women', title, 'Dresses', 'dresses_women.jpg'),
              _buildGridTile('Women', title, 'Co-ords', 'co-ords_women.jpg'),
              _buildGridTile('Women', title, 'Swimwear', 'swimwear_women.jpg'),
              _buildGridTile(
                  'Women', title, 'Outerwear', 'outerwear_women.jpg'),
              _buildGridTile(
                  'Women', title, 'Sleep&Lounge', 'loungewear_women.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelClothesMen(String title, bool expanded) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
        );
      },
      body: Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              _buildGridTile('Men', title, 'Tops', 'tops.jpg'),
              _buildGridTile('Men', title, 'Bottoms', 'bottoms_men.jpg'),
              _buildGridTile('Men', title, 'Loungewear', 'loungewear.jpg'),
              _buildGridTile('Men', title, 'Outerwear', 'outerwear.jpg'),
              _buildGridTile('Men', title, 'Co-ords', 'co-ords_men.jpg'),
              _buildGridTile('Men', title, 'Underwear', 'underwear_men.jpg'),
              _buildGridTile('Men', title, 'Swimwear', 'swimwear.jpg'),
              _buildGridTile(
                  'Men', title, 'Suits&Separates', 'suits_and_separates.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelActivewearMen(
      String title, bool expanded) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
        );
      },
      body: Column(
        children: [
          GridView.count(
            childAspectRatio: 1.2,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              _buildGridTile('Men', title, 'Tops', 'tops_activewear_men.jpg'),
              _buildGridTile(
                  'Men', title, 'Bottoms', 'bottoms_activewear_men.jpg'),
              _buildGridTile('Men', title, 'Accessories',
                  'accessories_activewear_men.jpg'),
              _buildGridTile('Men', title, 'Sets', 'sets_activewear_men.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelAccessoriesWomen(
      String title, bool expanded) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
        );
      },
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              childAspectRatio: 1.3,
              shrinkWrap: true,
              crossAxisCount: 3,
              children: [
                _buildGridTile('Women', title, 'Glasses', 'glasses.jpg'),
                _buildGridTile('Women', title, 'Watches', 'watches.jpg'),
                _buildGridTile('Women', title, 'Jewelery', 'jewelery.jpg'),
                _buildGridTile('Women', title, 'Belts', 'belts.jpg'),
                _buildGridTile('Women', title, 'Scarves', 'scarves.jpg'),
                _buildGridTile('Women', title, 'Gloves', 'gloves.jpg'),
                _buildGridTile('Women', title, 'Beret', 'beret.jpg'),
                _buildGridTile('Women', title, 'Hats', 'hats.jpg'),
                _buildGridTile(
                    'Women', title, 'Hair Accessories', 'hair_accessories.jpg'),
                _buildGridTile('Women', title, 'Socks', 'socks.jpg'),
                _buildGridTile('Women', title, 'Keychains', 'keychain.jpg'),
                _buildGridTile('Women', title, 'Others', 'others.jpg'),
              ],
            ),
          ],
        ),
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelAccessoriesMen(
      String title, bool expanded) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
        );
      },
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              childAspectRatio: 1.3,
              shrinkWrap: true,
              crossAxisCount: 3,
              children: [
                _buildGridTile('Men', title, 'Glasses', 'glasses_men.jpg'),
                _buildGridTile('Men', title, 'Watches', 'watches_men.jpg'),
                _buildGridTile('Men', title, 'Socks', 'socks_men.jpg'),
                _buildGridTile('Men', title, 'Belts&suspenders',
                    'belts_suspenders_men.jpg'),
                _buildGridTile(
                    'Men', title, 'Hats&Gloves', 'hats_gloves_men.jpg'),
                _buildGridTile('Men', title, 'Scarves', 'scarves_men.jpg'),
                _buildGridTile('Men', title, 'Ties', 'ties_men.jpg'),
                _buildGridTile('Men', title, 'Keychains', 'keychains_men.jpg'),
                _buildGridTile('Men', title, 'Necklaces', 'necklaces_men.jpg'),
                _buildGridTile('Men', title, 'Rings', 'rings_men.jpg'),
                _buildGridTile('Men', title, 'Bracelets', 'bracelets_men.jpg'),
                _buildGridTile('Men', title, 'Others', 'others.jpg'),
              ],
            ),
          ],
        ),
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelMaternityWomen(
      String title, bool expanded) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
        );
      },
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              childAspectRatio: 1.2,
              shrinkWrap: true,
              crossAxisCount: 3,
              children: [
                _buildGridTile('Women', title, 'Tops', 'tops_maternity.jpg'),
                _buildGridTile('Women', title, 'Bottoms', 'bottoms.jpg'),
                _buildGridTile('Women', title, 'Lingerie', 'lingerie.jpg'),
                _buildGridTile(
                    'Women', title, 'Accessories', 'accessories.jpg'),
                _buildGridTile('Women', title, 'Dresses', 'dresses.jpg'),
              ],
            ),
          ],
        ),
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelShoesWomen(String title, bool expanded) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
        );
      },
      body: Column(
        children: [
          GridView.count(
            childAspectRatio: 1.2,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              _buildGridTile('Women', title, 'Boots', 'boots.jpg'),
              _buildGridTile('Women', title, 'Water Shoes', 'water_shoes.jpg'),
              _buildGridTile('Women', title, 'Slippers', 'slippers.jpg'),
              _buildGridTile('Women', title, 'Sneakers', 'sneakers.jpg'),
              _buildGridTile('Women', title, 'Clogs', 'clogs.jpg'),
              _buildGridTile('Women', title, 'Sandals', 'sandals.png'),
              _buildGridTile('Women', title, 'Flats', 'flats.jpg'),
              _buildGridTile('Women', title, 'Pumps', 'pumps.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelShoesMen(String title, bool expanded) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
        );
      },
      body: Column(
        children: [
          GridView.count(
            childAspectRatio: 1.2,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              _buildGridTile('Men', title, 'Loafers', 'loafers_men.jpg'),
              _buildGridTile('Men', title, 'Sneakers', 'sneakers_men.jpg'),
              _buildGridTile('Men', title, 'Sandals', 'sandals_men.jpg'),
              _buildGridTile(
                  'Men', title, 'Dress Shoes', 'dress_shoes_men.jpg'),
              _buildGridTile('Men', title, 'Flip Flops', 'flipflops_men.jpg'),
              _buildGridTile('Men', title, 'Boots', 'boots_men.jpg'),
              _buildGridTile('Men', title, 'Slippers', 'slippers_men.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelActiveWearWomen(
      String title, bool expanded) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
        );
      },
      body: Column(
        children: [
          GridView.count(
            childAspectRatio: 1.2,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              _buildGridTile(
                  'Women', title, 'Tops', 'tops_activewear_women.jpg'),
              _buildGridTile(
                  'Women', title, 'Bottoms', 'bottoms_activewear_women.jpg'),
              _buildGridTile(
                  'Women', title, 'Dresses', 'dresses_activewear.jpg'),
              _buildGridTile('Women', title, 'Sets', 'sets_women.jpg'),
              _buildGridTile(
                  'Women', title, 'Outdoor Shoes', 'outdoor_shoes_women.jpg'),
              _buildGridTile('Women', title, 'Accessories',
                  'accessories_activewear_women.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelCosmeticsWomen(
      String title, bool expanded) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
        );
      },
      body: Column(
        children: [
          GridView.count(
            childAspectRatio: 1.2,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              _buildGridTile('Women', title, 'Skincare', 'skincare.jpg'),
              _buildGridTile('Women', title, 'Manicure/Pedicure',
                  'menicure_and_pedicure.jpg'),
              _buildGridTile('Women', title, 'Hair', 'hair.jpg'),
              _buildGridTile('Women', title, 'Bath&Body', 'bath_and_body.jpg'),
              _buildGridTile(
                  'Women', title, 'Perfume', 'perfume_and_deodorant.jpg'),
              _buildGridTile('Women', title, 'Eye', 'eye_makeup.jpg'),
              _buildGridTile('Women', title, 'Lips', 'lips.jpg'),
              _buildGridTile('Women', title, 'Face', 'face.jpg'),
              _buildGridTile(
                  'Women', title, 'Brushes&Tools', 'brushes&tools.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  Widget _buildExpansionListWomen(
    String title,
  ) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(2),
        child: ExpansionPanelList(
          animationDuration: Duration(milliseconds: 250),
          children: [
            _buildExpansionPanelBagsWomen('Bags', _expanded),
            _buildExpansionPanelShoesWomen('Shoes', _expanded2),
            _buildExpansionPanelClothesWomen('Clothes', _expanded3),
            _buildExpansionPanelAccessoriesWomen('Accessories', _expanded4),
            _buildExpansionPanelMaternityWomen('Maternity', _expanded5),
            _buildExpansionPanelActiveWearWomen('Activewear', _expanded6),
            _buildExpansionPanelCosmeticsWomen('Cosmetics', _expanded7),
          ],
          dividerColor: Colors.grey[300],
          elevation: 1.0,
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              if (panelIndex == 0) {
                _expanded = !_expanded;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = false;
                _expanded6 = false;
                _expanded7 = false;
              } else if (panelIndex == 1) {
                _expanded = false;
                _expanded2 = !_expanded2;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = false;
                _expanded6 = false;
                _expanded7 = false;
              } else if (panelIndex == 2) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = !_expanded3;
                _expanded4 = false;
                _expanded5 = false;
                _expanded6 = false;
                _expanded7 = false;
              } else if (panelIndex == 3) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = !_expanded4;
                _expanded5 = false;
                _expanded6 = false;
                _expanded7 = false;
              } else if (panelIndex == 4) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = !_expanded5;
                _expanded6 = false;
                _expanded7 = false;
              } else if (panelIndex == 5) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = false;
                _expanded6 = !_expanded6;
                _expanded7 = false;
              } else if (panelIndex == 6) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = false;
                _expanded6 = false;
                _expanded7 = !_expanded7;
              }
            });
          },
        ),
      ),
    ]);
  }

  Widget _buildExpansionListKids(
    String title,
  ) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(10),
        child: ExpansionPanelList(
          animationDuration: Duration(milliseconds: 250),
          children: [
            _buildExpansionPanelBabyKids('Baby', _expanded),
            _buildExpansionPanelBoysKids('Boys', _expanded2),
            _buildExpansionPanelGirlsKids('Girls', _expanded3),
            _buildExpansionPanelToysKids('Toys', _expanded4),
          ],
          dividerColor: Colors.grey[300],
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              if (panelIndex == 0) {
                _expanded = !_expanded;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = false;
              } else if (panelIndex == 1) {
                _expanded = false;
                _expanded2 = !_expanded2;
                _expanded3 = false;
                _expanded4 = false;
              } else if (panelIndex == 2) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = !_expanded3;
                _expanded4 = false;
              } else if (panelIndex == 3) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = !_expanded4;
              }
            });
          },
        ),
      ),
    ]);
  }

  ExpansionPanel _buildExpansionPanelBabyKids(String title, bool expanded) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
        );
      },
      body: Column(
        children: [
          GridView.count(
            childAspectRatio: 1.2,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              _buildGridTile('Kids', title, 'Clothing', 'clothing_baby.jpg'),
              _buildGridTile(
                  'Kids', title, 'Accessories', 'accessories_baby.jpg'),
              _buildGridTile(
                  'Kids', title, 'Activity&gear', 'activity_and_gear.jpg'),
              _buildGridTile('Kids', title, 'Babycare', 'babycare.jpg'),
              _buildGridTile('Kids', title, 'Bedding', 'baby_bedding.jpg'),
              _buildGridTile('Kids', title, 'Shoes', 'shoes_baby.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelGirlsKids(String title, bool expanded) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
        );
      },
      body: Column(
        children: [
          GridView.count(
            childAspectRatio: 1.2,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              _buildGridTile('Kids', title, 'Tops', 'tops_girls.jpg'),
              _buildGridTile('Kids', title, 'Bottoms', 'bottoms_girls.jpg'),
              _buildGridTile('Kids', title, 'Outerwear', 'outerwear_girls.jpg'),
              _buildGridTile('Kids', title, 'Shoes', 'shoes_girls.jpg'),
              _buildGridTile(
                  'Kids', title, 'Accessories', 'accessories_girls.jpg'),
              _buildGridTile(
                  'Kids', title, 'Loungewear', 'loungewear_girls.jpg'),
              _buildGridTile('Kids', title, 'Swimwear', 'swimwear_girls.jpg'),
              _buildGridTile('Kids', title, 'Underwear', 'underwear_girls.jpg'),
              _buildGridTile('Kids', title, 'Two-piece', 'two-piece_girls.jpg'),
              _buildGridTile('Kids', title, 'Bags', 'bags_girls.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelBoysKids(String title, bool expanded) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
        );
      },
      body: Column(
        children: [
          GridView.count(
            childAspectRatio: 1.2,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              _buildGridTile('Kids', title, 'Tops', 'tops_boys.jpg'),
              _buildGridTile('Kids', title, 'Bottoms', 'bottoms_boys.jpg'),
              _buildGridTile('Kids', title, 'Outerwear', 'outerwear_boys.jpg'),
              _buildGridTile('Kids', title, 'Shoes', 'shoes_boys.jpg'),
              _buildGridTile(
                  'Kids', title, 'Accessories', 'accessories_boys.jpg'),
              _buildGridTile(
                  'Kids', title, 'Loungewear', 'loungewear_boys.jpg'),
              _buildGridTile('Kids', title, 'Swimwear', 'swimwear_boys.jpg'),
              _buildGridTile('Kids', title, 'Underwear', 'underwear_boys.jpg'),
              _buildGridTile(
                  'Kids', title, 'Two-piece', 'two-piece_outfits.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelToysKids(String title, bool expanded) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
        );
      },
      body: Column(
        children: [
          GridView.count(
            childAspectRatio: 1.2,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              _buildGridTile('Kids', title, 'Educational', 'educational.jpg'),
              _buildGridTile('Kids', title, 'Dolls', 'dolls.jpg'),
              _buildGridTile(
                  'Kids', title, 'Action Figures', 'action_figures.jpg'),
              _buildGridTile(
                  'Kids', title, 'Games&Puzzles', 'games_and_puzzles.jpg'),
              _buildGridTile(
                  'Kids', title, 'Outdoor Toys', 'outdoor_seasonal_toys.jpg'),
              _buildGridTile('Kids', title, 'Arts&Crafts', 'arts&crafts.jpg'),
              _buildGridTile('Kids', title, 'Vehicles', 'vehicles.jpg'),
              _buildGridTile('Kids', title, 'Ride ons', 'ride_ons.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  Widget _buildExpansionListMen(
    String title,
  ) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(10),
        child: ExpansionPanelList(
          animationDuration: Duration(milliseconds: 250),
          children: [
            _buildExpansionPanelBagsMen('Bags', _expanded),
            _buildExpansionPanelShoesMen('Shoes', _expanded2),
            _buildExpansionPanelClothesMen('Clothes', _expanded3),
            _buildExpansionPanelAccessoriesMen('Accessories', _expanded4),
            _buildExpansionPanelActivewearMen('Activewear', _expanded5),
          ],
          dividerColor: Colors.grey[300],
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              if (panelIndex == 0) {
                _expanded = !_expanded;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = false;
              } else if (panelIndex == 1) {
                _expanded = false;
                _expanded2 = !_expanded2;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = false;
              } else if (panelIndex == 2) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = !_expanded3;
                _expanded4 = false;
                _expanded5 = false;
              } else if (panelIndex == 3) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = !_expanded4;
                _expanded5 = false;
              } else if (panelIndex == 4) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = !_expanded5;
              }
            });
          },
        ),
      ),
    ]);
  }

  Widget _buildExpansionListPets(
    String title,
  ) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(10),
        child: ExpansionPanelList(
          animationDuration: Duration(milliseconds: 250),
          children: [
            _buildExpansionPanelCats('Cats', _expanded),
            _buildExpansionPanelDogs('Dogs', _expanded2),
            _buildExpansionPanelBirds('Birds', _expanded3),
            _buildExpansionPanelFish('Fish', _expanded4),
          ],
          dividerColor: Colors.grey[300],
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              if (panelIndex == 0) {
                _expanded = !_expanded;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = false;
              } else if (panelIndex == 1) {
                _expanded = false;
                _expanded2 = !_expanded2;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = false;
              } else if (panelIndex == 2) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = !_expanded3;
                _expanded4 = false;
                _expanded5 = false;
              } else if (panelIndex == 3) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = !_expanded4;
                _expanded5 = false;
              } else if (panelIndex == 4) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = !_expanded5;
              }
            });
          },
        ),
      ),
    ]);
  }

  ExpansionPanel _buildExpansionPanelCats(String title, bool expanded) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
        );
      },
      body: Column(
        children: [
          GridView.count(
            childAspectRatio: 1.2,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              _buildGridTile('Pets', title, 'Beds', 'beds_cats.jpg'),
              _buildGridTile('Pets', title, 'Bowls', 'bowls_cats.jpg'),
              _buildGridTile('Pets', title, 'Behavior', 'behavior_cats.jpg'),
              _buildGridTile('Pets', title, 'Cans', 'cans_cats.jpg'),
              _buildGridTile('Pets', title, 'Collars', 'collars_cats.png'),
              _buildGridTile('Pets', title, 'Carriers', 'carriers_cats.jpg'),
              _buildGridTile('Pets', title, 'Furniture', 'furniture_cats.jpg'),
              _buildGridTile('Pets', title, 'Grooming', 'grooming_cats.jpg'),
              _buildGridTile('Pets', title, 'Litter', 'litter_cats.jpg'),
              _buildGridTile('Pets', title, 'Medicines', 'medicines_cats.jpg'),
              _buildGridTile(
                  'Pets', title, 'Scratchers', 'scratchers_cats.jpg'),
              _buildGridTile('Pets', title, 'Toys', 'toys_cats.jpg'),
              _buildGridTile('Pets', title, 'Treats', 'treats_cats.jpg'),
              _buildGridTile('Pets', title, 'Dry Food', 'dry_food_cats.jpg'),
              _buildGridTile('Pets', title, 'Kitten', 'kitten_cats.jpg'),
              _buildGridTile(
                  'Pets', title, 'Veterinary Diet', 'veterinary_diet_cats.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelDogs(String title, bool expanded) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
        );
      },
      body: Column(
        children: [
          GridView.count(
            childAspectRatio: 1.2,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              _buildGridTile('Pets', title, 'Behavior', 'behavior_dogs.jpg'),
              _buildGridTile('Pets', title, 'Beds', 'beds_dogs.jpg'),
              _buildGridTile('Pets', title, 'Bowls', 'bowls_dogs.jpg'),
              _buildGridTile('Pets', title, 'Cans', 'cans_dogs.jpg'),
              _buildGridTile(
                  'Pets', title, 'Collars&Coats', 'collars_coats_dogs.jpg'),
              _buildGridTile('Pets', title, 'Fashion', 'fashion_dogs.jpg'),
              _buildGridTile('Pets', title, 'Grooming', 'grooming_dogs.jpg'),
              _buildGridTile('Pets', title, 'Kennels&Carries',
                  'kennels_carriers_dogs.jpg'),
              _buildGridTile('Pets', title, 'Medicines', 'medicines_dogs.jpg'),
              _buildGridTile('Pets', title, 'Toys', 'toys_dogs.jpg'),
              _buildGridTile('Pets', title, 'Treats', 'treats_dogs.png'),
              _buildGridTile('Pets', title, 'Dry Food', 'dry_food_dogs.jpg'),
              _buildGridTile(
                  'Pets', title, 'Control&Wormers', 'control_wormers_dogs.jpg'),
              _buildGridTile(
                  'Pets', title, 'Poop Scoop&Bags', 'poop_scoop_bags_dogs.jpg'),
              _buildGridTile('Pets', title, 'Raw Food', 'raw_dogs.jpg'),
              _buildGridTile('Pets', title, 'Puppy', 'puppy_dogs.jpg'),
              _buildGridTile('Pets', title, 'Veterinary Diets',
                  'veterinary_diets_dogs.jpg'),
              _buildGridTile(
                  'Pets', title, 'Training Aids', 'training_aids_dogs.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelBirds(String title, bool expanded) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
        );
      },
      body: Column(
        children: [
          GridView.count(
            childAspectRatio: 1.2,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              _buildGridTile('Pets', title, 'Food', 'food_birds.jpg'),
              _buildGridTile(
                  'Pets', title, 'Accessories', 'accessories_birds.jpg'),
              _buildGridTile('Pets', title, 'Medicines', 'medicines_birds.jpg'),
              _buildGridTile('Pets', title, 'Feeders', 'feeders_birds.jpg'),
              _buildGridTile('Pets', title, 'Feeding Stations',
                  'feeding_stations_birds.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelFish(String title, bool expanded) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
        );
      },
      body: Column(
        children: [
          GridView.count(
            childAspectRatio: 1.2,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              _buildGridTile('Pets', title, 'Tank Equipment', 'tank_fish.jpg'),
              _buildGridTile('Pets', title, 'Food', 'food_fish.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  Widget _buildBooks(String title, bool expanded) {
    return Column(
      children: [
        GridView.count(
          childAspectRatio: 1.2,
          shrinkWrap: true,
          crossAxisCount: 3,
          children: [
            _buildGridTile(
                'Books', 'none', 'Family, Parents', 'family_parents_books.jpg'),
            _buildGridTile('Books', 'none', 'Lifestyle, Health',
                'lifestyle_health_books.jpg'),
            _buildGridTile('Books', 'none', 'Biographies, Memoirs',
                'biographies_memoirs_books.jpg'),
            _buildGridTile('Books', 'none', 'Esoteric', 'esoteric_books.jpg'),
            _buildGridTile(
                'Books', 'none', 'Gastronomy', 'gastronomy_books.jpg'),
            _buildGridTile(
                'Books', 'none', 'Children&Youth', 'children_youth_books.jpg'),
            _buildGridTile(
                'Books', 'none', 'Audiobook', 'audiobooks_books.jpg'),
            _buildGridTile('Books', 'none', 'Hobbies, Free Time',
                'hobbies_freetime_books.jpg'),
            _buildGridTile(
                'Books', 'none', 'Literature', 'literature_books.jpg'),
            _buildGridTile('Books', 'none', 'Comic Books', 'comic_books.jpg'),
            _buildGridTile(
                'Books', 'none', 'Garden, Home', 'garden_home_books.jpg'),
            _buildGridTile('Books', 'none', 'Lexicon, Encyclopedia',
                'lexicon_encyclopedia_books.jpg'),
            _buildGridTile('Books', 'none', 'Art, Architecture',
                'art_architecture_books.jpg'),
            _buildGridTile('Books', 'none', 'Nowadays, Politics',
                'nowadays_tabloids_politics_books.jpg'),
            _buildGridTile('Books', 'none', 'Language, Dictionary',
                'language_dictionary_books.jpg'),
            _buildGridTile('Books', 'none', 'Economy, Business',
                'money_economy_business_books.jpg'),
            _buildGridTile('Books', 'none', 'Sports, Nature Walks',
                'sports_nature_walks_books.jpg'),
            _buildGridTile('Books', 'none', 'Computer, Technology',
                'computer_internet_books.jpg'),
            _buildGridTile('Books', 'none', 'Textbooks, Reference',
                'textbooks_reference_books.jpg'),
            _buildGridTile('Books', 'none', 'Map', 'map_books.jpg'),
            _buildGridTile('Books', 'none', 'History', 'history_books.jpg'),
            _buildGridTile(
                'Books', 'none', 'Science, Nature', 'science_nature_books.jpg'),
            _buildGridTile('Books', 'none', 'Travel', 'travel_books.jpg'),
            _buildGridTile('Books', 'none', 'Mythology', 'mythology_books.jpg'),
          ],
        ),
      ],
    );
  }

  Tab _buildSideTab(String text, String image) {
    return Tab(
      child: Container(
        height: 80,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: AssetImage(
                          'images/${image}',
                        ))),
              ),
            ),
            Center(
              child: Text(
                text,
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
            ),
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
        iconTheme: IconThemeData(
          color: const Color.fromARGB(255, 255, 115, 0),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: VerticalTabs(
        contentScrollAxis: Axis.vertical,
        tabsElevation: 1,
        indicatorColor: Colors.white,
        tabsShadowColor: Colors.black,
        tabBackgroundColor: Colors.white,
        selectedTabBackgroundColor: Color.fromARGB(255, 255, 195, 145),
        backgroundColor: Colors.white,
        onSelect: ((tabIndex) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _expanded = false;
              _expanded2 = false;
              _expanded3 = false;
              _expanded4 = false;
              _expanded5 = false;
              _expanded6 = false;
              _expanded7 = false;
            });
          });
        }),
        tabsWidth: 80,
        tabs: <Tab>[
          _buildSideTab('Women', 'dress_icon.png'),
          _buildSideTab('Kids', 'shoes_icon.png'),
          _buildSideTab('Men', 'tie_icon.png'),
          _buildSideTab('Pets', 'cats_and_dogs_icon.png'),
          _buildSideTab('Books', 'books_icon.png'),
          _buildSideTab('Household', 'household_icon.png'),
          _buildSideTab('Electronics', 'electronics_icon.png'),
        ],
        contents: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                _buildExpansionListWomen('Clothes'),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                _buildExpansionListKids('Clothes'),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                _buildExpansionListMen('Clothes'),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                _buildExpansionListPets('Pets'),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [_buildBooks('books', true)],
            ),
          ),
          Container(
            child: Center(child: Text('Household')),
          ),
          Container(
            child: Center(child: Text('Electronics')),
          ),
        ],
      ),
    );
  }
}
