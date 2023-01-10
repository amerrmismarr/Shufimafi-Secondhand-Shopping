import 'package:dolabi/screens/search.dart';
import 'package:dolabi/screens/search_with_filter.dart';
import 'package:dolabi/screens/tabs_with_screens.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

class DrawerWidget extends StatefulWidget {
  final void Function(String) onSearchResult;

  const DrawerWidget({
    Key? key,
    required this.onSearchResult,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState(onSearchResult);
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final void Function(String) onSearchResult;

  _DrawerWidgetState(this.onSearchResult);
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

  String? searchText;

  Color mainColor = const Color.fromARGB(255, 255, 115, 0);

  Widget _buildExpansionPanelImage(String image) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/${image}'))),
    );
  }

  Widget _buildGridTile(String title, String image) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => SearchWithFilter(
                  searchText: title,
                )));
      },
      child: GridTile(
          footer: Center(
            child: Text(
              title,
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
              _buildGridTile('Shoulder Bags', 'shoulder_bag.jpg'),
              _buildGridTile('Clutches', 'clutch.jpg'),
              _buildGridTile('Purses', 'purse.jpg'),
              _buildGridTile('Crossbody', 'crossbody.jpg'),
              _buildGridTile('Backpacks', 'backpack.jpg'),
              _buildGridTile('Fanny packs', 'fannypack.jpg'),
              _buildGridTile('Tote Bags', 'tote_bag.jpg'),
              _buildGridTile('Satchels', 'satchel.jpg'),
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
              _buildGridTile('Clutches&Wallets', 'clutches_wallets_men.jpg'),
              _buildGridTile('Fanny Packs', 'fanny_packs_men.jpg'),
              _buildGridTile('Crossbody Bags', 'crossbody_bags_men.jpg'),
              _buildGridTile('Backpacks', 'backpacks_men.jpg'),
              _buildGridTile('Tote Bags', 'tote_bags_men.jpg'),
              _buildGridTile('Briefcases', 'briefcases_men.jpg'),
              _buildGridTile('Bag Sets', 'bag_sets_men.jpg'),
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
              _buildGridTile('Tops', 'tops_women.jpg'),
              _buildGridTile('Bottoms', 'bottoms_women.jpg'),
              _buildGridTile('Dresses', 'dresses_women.jpg'),
              _buildGridTile('Co-ords', 'co-ords_women.jpg'),
              _buildGridTile('Swimwear', 'swimwear_women.jpg'),
              _buildGridTile('Outerwear', 'outerwear_women.jpg'),
              _buildGridTile('Sleep&Lounge', 'loungewear_women.jpg'),
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
              _buildGridTile('Tops', 'tops.jpg'),
              _buildGridTile('Bottoms', 'bottoms_men.jpg'),
              _buildGridTile('Loungewear', 'loungewear.jpg'),
              _buildGridTile('Outerwear', 'outerwear.jpg'),
              _buildGridTile('Co-ords', 'co-ords_men.jpg'),
              _buildGridTile('Underwear', 'underwear_men.jpg'),
              _buildGridTile('Swimwear', 'swimwear.jpg'),
              _buildGridTile('Suits&Separates', 'suits_and_separates.jpg'),
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
              _buildGridTile('Tops', 'tops_activewear_men.jpg'),
              _buildGridTile('Bottoms', 'bottoms_activewear_men.jpg'),
              _buildGridTile('Accessories', 'accessories_activewear_men.jpg'),
              _buildGridTile('Sets', 'sets_activewear_men.jpg'),
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
                _buildGridTile('Glasses', 'glasses.jpg'),
                _buildGridTile('Watches', 'watches.jpg'),
                _buildGridTile('Jewelery', 'jewelery.jpg'),
                _buildGridTile('Belts', 'belts.jpg'),
                _buildGridTile('Scarves', 'scarves.jpg'),
                _buildGridTile('Gloves', 'gloves.jpg'),
                _buildGridTile('Beret', 'beret.jpg'),
                _buildGridTile('Hats', 'hats.jpg'),
                _buildGridTile('Hair Accessories', 'hair_accessories.jpg'),
                _buildGridTile('Socks', 'socks.jpg'),
                _buildGridTile('Keychains', 'keychain.jpg'),
                _buildGridTile('Others', 'others.jpg'),
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
                _buildGridTile('Glasses', 'glasses_men.jpg'),
                _buildGridTile('Watches', 'watches_men.jpg'),
                _buildGridTile('Socks', 'socks_men.jpg'),
                _buildGridTile('Belts&suspenders', 'belts_suspenders_men.jpg'),
                _buildGridTile('Hats&Gloves', 'hats_gloves_men.jpg'),
                _buildGridTile('Scarves', 'scarves_men.jpg'),
                _buildGridTile('Ties', 'ties_men.jpg'),
                _buildGridTile('Keychains', 'keychains_men.jpg'),
                _buildGridTile('Necklaces', 'necklaces_men.jpg'),
                _buildGridTile('Rings', 'rings_men.jpg'),
                _buildGridTile('Bracelets', 'bracelets_men.jpg'),
                _buildGridTile('Others', 'others.jpg'),
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
                _buildGridTile('Tops', 'tops_maternity.jpg'),
                _buildGridTile('Bottoms', 'bottoms.jpg'),
                _buildGridTile('Lingerie', 'lingerie.jpg'),
                _buildGridTile('Accessories', 'accessories.jpg'),
                _buildGridTile('Dresses', 'dresses.jpg'),
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
              _buildGridTile('Boots', 'boots.jpg'),
              _buildGridTile('Water Shoes', 'water_shoes.jpg'),
              _buildGridTile('Slippers', 'slippers.jpg'),
              _buildGridTile('Sneakers', 'sneakers.jpg'),
              _buildGridTile('Clogs', 'clogs.jpg'),
              _buildGridTile('Sandals', 'sandals.png'),
              _buildGridTile('Flats', 'flats.jpg'),
              _buildGridTile('Pumps', 'pumps.jpg'),
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
              _buildGridTile('Loafers', 'loafers_men.jpg'),
              _buildGridTile('Sneakers', 'sneakers_men.jpg'),
              _buildGridTile('Sandals', 'sandals_men.jpg'),
              _buildGridTile('Dress Shoes', 'dress_shoes_men.jpg'),
              _buildGridTile('Flip Flops', 'flipflops_men.jpg'),
              _buildGridTile('Boots', 'boots_men.jpg'),
              _buildGridTile('Slippers', 'slippers_men.jpg'),
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
              _buildGridTile('Tops', 'tops_activewear_women.jpg'),
              _buildGridTile('Bottoms', 'bottoms_activewear_women.jpg'),
              _buildGridTile('Dresses', 'dresses_activewear.jpg'),
              _buildGridTile('Sets', 'sets_women.jpg'),
              _buildGridTile('Outdoor Shoes', 'outdoor_shoes_women.jpg'),
              _buildGridTile('Accessories', 'accessories_activewear_women.jpg'),
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
              _buildGridTile('Skincare', 'skincare.jpg'),
              _buildGridTile('Manicure/Pedicure', 'menicure_and_pedicure.jpg'),
              _buildGridTile('Hair', 'hair.jpg'),
              _buildGridTile('Bath&Body', 'bath_and_body.jpg'),
              _buildGridTile('Perfume', 'perfume_and_deodorant.jpg'),
              _buildGridTile('Eye', 'eye_makeup.jpg'),
              _buildGridTile('Lips', 'lips.jpg'),
              _buildGridTile('Face', 'face.jpg'),
              _buildGridTile('Brushes&Tools', 'brushes&tools.jpg'),
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
              _buildGridTile('Clothing', 'clothing_baby.jpg'),
              _buildGridTile('Accessories', 'accessories_baby.jpg'),
              _buildGridTile('Activity&gear', 'activity_and_gear.jpg'),
              _buildGridTile('Babycare', 'babycare.jpg'),
              _buildGridTile('Bedding', 'baby_bedding.jpg'),
              _buildGridTile('Shoes', 'shoes_baby.jpg'),
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
              _buildGridTile('Tops', 'tops_girls.jpg'),
              _buildGridTile('Bottoms', 'bottoms_girls.jpg'),
              _buildGridTile('Outerwear', 'outerwear_girls.jpg'),
              _buildGridTile('Shoes', 'shoes_girls.jpg'),
              _buildGridTile('Accessories', 'accessories_girls.jpg'),
              _buildGridTile('Loungewear', 'loungewear_girls.jpg'),
              _buildGridTile('Swimwear', 'swimwear_girls.jpg'),
              _buildGridTile('Underwear', 'underwear_girls.jpg'),
              _buildGridTile('Two-piece', 'two-piece_girls.jpg'),
              _buildGridTile('Bags', 'bags_girls.jpg'),
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
              _buildGridTile('Tops', 'tops_boys.jpg'),
              _buildGridTile('Bottoms', 'bottoms_boys.jpg'),
              _buildGridTile('Outerwear', 'outerwear_boys.jpg'),
              _buildGridTile('Shoes', 'shoes_boys.jpg'),
              _buildGridTile('Accessories', 'accessories_boys.jpg'),
              _buildGridTile('Loungewear', 'loungewear_boys.jpg'),
              _buildGridTile('Swimwear', 'swimwear_boys.jpg'),
              _buildGridTile('Underwear', 'underwear_boys.jpg'),
              _buildGridTile('Two-piece', 'two-piece_outfits.jpg'),
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
              _buildGridTile('Educational', 'educational.jpg'),
              _buildGridTile('Dolls', 'dolls.jpg'),
              _buildGridTile('Action Figures', 'action_figures.jpg'),
              _buildGridTile('Games&Puzzles', 'games_and_puzzles.jpg'),
              _buildGridTile('Outdoor Toys', 'outdoor_seasonal_toys.jpg'),
              _buildGridTile('Arts&Crafts', 'arts&crafts.jpg'),
              _buildGridTile('Vehicles', 'vehicles.jpg'),
              _buildGridTile('Ride ons', 'ride_ons.jpg'),
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
              _buildGridTile('Beds', 'beds_cats.jpg'),
              _buildGridTile('Bowls', 'bowls_cats.jpg'),
              _buildGridTile('Behavior', 'behavior_cats.jpg'),
              _buildGridTile('Cans', 'cans_cats.jpg'),
              _buildGridTile('Collars', 'collars_cats.png'),
              _buildGridTile('Carriers', 'carriers_cats.jpg'),
              _buildGridTile('Furniture', 'furniture_cats.jpg'),
              _buildGridTile('Grooming', 'grooming_cats.jpg'),
              _buildGridTile('Litter', 'litter_cats.jpg'),
              _buildGridTile('Medicines', 'medicines_cats.jpg'),
              _buildGridTile('Scratchers', 'scratchers_cats.jpg'),
              _buildGridTile('Toys', 'toys_cats.jpg'),
              _buildGridTile('Treats', 'treats_cats.jpg'),
              _buildGridTile('Dry Food', 'dry_food_cats.jpg'),
              _buildGridTile('Kitten', 'kitten_cats.jpg'),
              _buildGridTile('Veterinary Diet', 'veterinary_diet_cats.jpg'),
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
              _buildGridTile('Behavior', 'behavior_dogs.jpg'),
              _buildGridTile('Beds', 'beds_dogs.jpg'),
              _buildGridTile('Bowls', 'bowls_dogs.jpg'),
              _buildGridTile('Cans', 'cans_dogs.jpg'),
              _buildGridTile('Collars&Coats', 'collars_coats_dogs.jpg'),
              _buildGridTile('Fashion', 'fashion_dogs.jpg'),
              _buildGridTile('Grooming', 'grooming_dogs.jpg'),
              _buildGridTile('Kennels&Carries', 'kennels_carriers_dogs.jpg'),
              _buildGridTile('Medicines', 'medicines_dogs.jpg'),
              _buildGridTile('Toys', 'toys_dogs.jpg'),
              _buildGridTile('Treats', 'treats_dogs.png'),
              _buildGridTile('Dry Food', 'dry_food_dogs.jpg'),
              _buildGridTile('Control&Wormers', 'control_wormers_dogs.jpg'),
              _buildGridTile('Poop Scoop&Bags', 'poop_scoop_bags_dogs.jpg'),
              _buildGridTile('Raw Food', 'raw_dogs.jpg'),
              _buildGridTile('Puppy', 'puppy_dogs.jpg'),
              _buildGridTile('Veterinary Diets', 'veterinary_diets_dogs.jpg'),
              _buildGridTile('Training Aids', 'training_aids_dogs.jpg'),
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
              _buildGridTile('Food', 'food_birds.jpg'),
              _buildGridTile('Accessories', 'accessories_birds.jpg'),
              _buildGridTile('Medicines', 'medicines_birds.jpg'),
              _buildGridTile('Feeders', 'feeders_birds.jpg'),
              _buildGridTile('Feeding Stations', 'feeding_stations_birds.jpg'),
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
              _buildGridTile('Tank Equipment', 'tank_fish.jpg'),
              _buildGridTile('Food', 'food_fish.jpg'),
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
            _buildGridTile('Family, Parents', 'family_parents_books.jpg'),
            _buildGridTile('Lifestyle, Health', 'lifestyle_health_books.jpg'),
            _buildGridTile(
                'Biographies, Memoirs', 'biographies_memoirs_books.jpg'),
            _buildGridTile('Esoteric', 'esoteric_books.jpg'),
            _buildGridTile('Gastronomy', 'gastronomy_books.jpg'),
            _buildGridTile('Children&Youth', 'children_youth_books.jpg'),
            _buildGridTile('Audiobook', 'audiobooks_books.jpg'),
            _buildGridTile('Hobbies, Free Time', 'hobbies_freetime_books.jpg'),
            _buildGridTile('Literature', 'literature_books.jpg'),
            _buildGridTile('Comic Books', 'comic_books.jpg'),
            _buildGridTile('Garden, Home', 'garden_home_books.jpg'),
            _buildGridTile(
                'Lexicon, Encyclopedia', 'lexicon_encyclopedia_books.jpg'),
            _buildGridTile('Art, Architecture', 'art_architecture_books.jpg'),
            _buildGridTile(
                'Nowadays, Politics', 'nowadays_tabloids_politics_books.jpg'),
            _buildGridTile(
                'Language, Dictionary', 'language_dictionary_books.jpg'),
            _buildGridTile(
                'Economy, Business', 'money_economy_business_books.jpg'),
            _buildGridTile(
                'Sports, Nature Walks', 'sports_nature_walks_books.jpg'),
            _buildGridTile(
                'Computer, Technology', 'computer_internet_books.jpg'),
            _buildGridTile(
                'Textbooks, Reference', 'textbooks_reference_books.jpg'),
            _buildGridTile('Map', 'map_books.jpg'),
            _buildGridTile('History', 'history_books.jpg'),
            _buildGridTile('Science, Nature', 'science_nature_books.jpg'),
            _buildGridTile('Travel', 'travel_books.jpg'),
            _buildGridTile('Mythology', 'mythology_books.jpg'),
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
              onPressed: () {
                Navigator.pop(
                    context,
                    PageTransition(
                        duration: Duration(milliseconds: 3000),
                        type: PageTransitionType.leftToRight,
                        child: TabsWithScreens()));
              },
              icon: Icon(Icons.arrow_back)),
          title: Container(
              width: double.infinity,
              height: 40,
              child: Center(
                child: TextField(
                  textAlignVertical: TextAlignVertical.bottom,
                  onChanged: (value) {
                    searchText = value;
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
                        icon: const Icon(Icons.forward),
                        onPressed: () {
                          //onSearchResult(searchText);
                          if (searchText != null) {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => Search(
                                          searchText: searchText,
                                        )));
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Search field is empty!',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: mainColor,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                      ),
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                          color: const Color.fromARGB(255, 255, 115, 0))),
                ),
              ))),
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
