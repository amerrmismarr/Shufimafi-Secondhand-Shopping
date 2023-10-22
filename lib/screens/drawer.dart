import 'package:dolabi/screens/search_cupboard.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vertical_tabs_flutter/vertical_tabs.dart';

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

  bool _expanded = false;
  bool _expanded2 = false;
  bool _expanded3 = false;
  bool _expanded4 = false;
  bool _expanded5 = false;
  bool _expanded6 = false;
  bool _expanded7 = false;
  bool _expanded8 = false;
  bool _expanded9 = false;
  bool _expanded10 = false;

  Color mainColor = const Color.fromARGB(255, 255, 115, 0);

  Widget _buildExpansionPanelImage(String image) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/$image'))),
    );
  }

  Widget _buildGridTile(String mainCategory, String middleCategory,
      String subCategory, String image) {
    return GestureDetector(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: SearchCupboard(
            mainCategory: mainCategory,
            middleCategory: middleCategory,
            subCategory: subCategory,
          ),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.slideUp,
        );
      },
      child: GridTile(
          footer: Center(
            child: Text(
              subCategory,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
              ),
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

  Widget _buildExpansionListHousehold(
    String title,
  ) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(10),
        child: ExpansionPanelList(
          animationDuration: Duration(milliseconds: 250),
          children: [
            _buildExpansionPanelHouseholdStorage('Storage', _expanded),
            _buildExpansionPanelHouseholdFurniture('Furniture', _expanded2),
            _buildExpansionPanelHouseholdTextiles('Textiles', _expanded3),
            _buildExpansionPanelHouseholdBedroom('Bedroom', _expanded4),
            _buildExpansionPanelHouseholdCookware(
                'Cookware & Tableware', _expanded5),
            _buildExpansionPanelHouseholdLighting('Lighting', _expanded6),
            _buildExpansionPanelHouseholdKitchen('Kitchen', _expanded7),
            _buildExpansionPanelHouseholdPlants('Plants', _expanded8),
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
                _expanded6 = false;
                _expanded7 = false;
                _expanded8 = false;
              } else if (panelIndex == 1) {
                _expanded = false;
                _expanded2 = !_expanded2;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = false;
                _expanded6 = false;
                _expanded7 = false;
                _expanded8 = false;
              } else if (panelIndex == 2) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = !_expanded3;
                _expanded4 = false;
                _expanded5 = false;
                _expanded6 = false;
                _expanded7 = false;
                _expanded8 = false;
              } else if (panelIndex == 3) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = !_expanded4;
                _expanded5 = false;
                _expanded6 = false;
                _expanded7 = false;
                _expanded8 = false;
              } else if (panelIndex == 4) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = !_expanded5;
                _expanded6 = false;
                _expanded7 = false;
                _expanded8 = false;
              } else if (panelIndex == 5) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = false;
                _expanded6 = !_expanded6;
                _expanded7 = false;
                _expanded8 = false;
              } else if (panelIndex == 6) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = false;
                _expanded6 = false;
                _expanded7 = !_expanded7;
                _expanded8 = false;
              } else if (panelIndex == 7) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = false;
                _expanded6 = false;
                _expanded7 = false;
                _expanded8 = !_expanded8;
              }
            });
          },
        ),
      ),
    ]);
  }

  ExpansionPanel _buildExpansionPanelHouseholdStorage(
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
              _buildGridTile('Household', title, 'Shelving Units',
                  'bookcases_shelving_units.jpg'),
              _buildGridTile('Household', title, 'Storage Systems',
                  'storage_solution_systems.jpg'),
              _buildGridTile('Household', title, 'Cabinets,Cupboards',
                  'cabinets_cupboards.jpg'),
              _buildGridTile('Household', title, 'TV & Media Furniture',
                  'tv_media_furniture.jpg'),
              _buildGridTile('Household', title, 'Drawer Units', 'drawers.jpg'),
              _buildGridTile('Household', title, 'Wardrobes', 'wardrobes.jpg'),
              _buildGridTile(
                  'Household', title, 'Small Storage', 'small_storage.jpg'),
              _buildGridTile('Household', title, 'Sideboards,Buffets',
                  'sideboards_buffets.jpg'),
              _buildGridTile('Household', title, 'Wall Organisation',
                  'wall organisation.jpg'),
              _buildGridTile(
                  'Household', title, 'Clothes Racks', 'clothes_racks.jpg'),
              _buildGridTile('Household', title, 'Trolleys', 'trolleys.jpg'),
              _buildGridTile('Household', title, 'Bags', 'bags.jpg'),
              _buildGridTile(
                  'Household', title, 'Moving Supplies', 'moving_supplies.jpg'),
              _buildGridTile(
                  'Household', title, 'Wall Shelves', 'wall_shelves.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelHouseholdFurniture(
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
              _buildGridTile('Household', title, 'Sofas', 'sofas.jpg'),
              _buildGridTile(
                  'Household', title, 'Tables & Desks', 'tables_desks.jpg'),
              _buildGridTile('Household', title, 'Chairs', 'chairs.jpg'),
              _buildGridTile('Household', title, 'Gaming Furniture',
                  'gaming_furniture.jpg'),
              _buildGridTile(
                  'Household', title, 'Furniture Sets', 'furniture_sets.jpg'),
              _buildGridTile('Household', title, 'Children\'s Furniture',
                  'children_furniture.jpg'),
              _buildGridTile('Household', title, 'Nursery Furniture',
                  'nursery_furniture.jpg'),
              _buildGridTile(
                  'Household', title, 'Chaise Longues', 'chaise_longues.jpg'),
              _buildGridTile(
                  'Household', title, 'Bar Furniture', 'bar_furniture.jpg'),
              _buildGridTile(
                  'Household', title, 'Cafe Furniture', 'cafe_furniture.jpg'),
              _buildGridTile(
                  'Household', title, 'Room Dividers', 'room_dividers.jpg'),
              _buildGridTile('Household', title, 'Garden Furniture',
                  'garden_furniture.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelHouseholdTextiles(
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
              _buildGridTile('Household', title, 'Curtains & Blinds',
                  'curtains_blinds.jpg'),
              _buildGridTile('Household', title, 'Cushions', 'cushions.jpg'),
              _buildGridTile('Household', title, 'Blankets & Throws',
                  'blankets_throws.jpg'),
              _buildGridTile(
                  'Household', title, 'Chair Pads', 'chair_pads.jpg'),
              _buildGridTile(
                  'Household', title, 'Bath Textiles', 'bath_textiles.jpg'),
              _buildGridTile('Household', title, 'Rugs', 'rugs.jpg'),
              _buildGridTile(
                  'Household', title, 'Fabrics & Sewing', 'fabrics_sewing.jpg'),
              _buildGridTile('Household', title, 'Kitchen Textiles',
                  'kitchen_textiles.jpg'),
              _buildGridTile('Household', title, 'Outdoor Cushions',
                  'outdoor_cushions.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelHouseholdBedroom(
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
              _buildGridTile('Household', title, 'Beds', 'beds.jpg'),
              _buildGridTile('Household', title, 'Bedding', 'bedding.jpg'),
              _buildGridTile(
                  'Household', title, 'Mattresses', 'mattresses.jpg'),
              _buildGridTile(
                  'Household', title, 'Bedside Tables', 'bedside_tables.jpg'),
              _buildGridTile(
                  'Household', title, 'Mattress Bases', 'mattress_bases.jpg'),
              _buildGridTile(
                  'Household', title, 'Headboards', 'headboards.jpg'),
              _buildGridTile('Household', title, 'Under Bed Storage',
                  'under_bed_storage.jpg'),
              _buildGridTile('Household', title, 'Bed Slats', 'bed_slats.jpg'),
              _buildGridTile('Household', title, 'Bed Legs', 'bed_legs.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelHouseholdCookware(
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
                  'Household', title, 'Food Storage', 'food_storage.jpg'),
              _buildGridTile(
                  'Household', title, 'Dinnerware', 'dinnerware.jpg'),
              _buildGridTile('Household', title, 'Serveware', 'serveware.jpg'),
              _buildGridTile(
                  'Household', title, 'Coffee & Tea', 'coffee_tea.jpg'),
              _buildGridTile(
                  'Household', title, 'Table Linen', 'table_linen.jpg'),
              _buildGridTile('Household', title, 'Cookware', 'cookware.jpg'),
              _buildGridTile(
                  'Household', title, 'Glassware & Jugs', 'glassware_jugs.jpg'),
              _buildGridTile('Household', title, 'Kitchen Utensils',
                  'kitchen_utensils.jpg'),
              _buildGridTile('Household', title, 'Dishwashing Accessories',
                  'dishwashing_accessories.jpg'),
              _buildGridTile('Household', title, 'Cutlery', 'cutlery.jpg'),
              _buildGridTile('Household', title, 'Knives & Chopping Boards',
                  'knives_chopping_boards.jpg'),
              _buildGridTile('Household', title, 'Bakeware', 'bakeware.jpg'),
              _buildGridTile(
                  'Household', title, 'Napkin Holders', 'napkin_holders.jpg'),
              _buildGridTile('Household', title, 'Children\'s Kitchenware',
                  'children_kitchenware_tableware.jpg'),
              _buildGridTile('Household', title, 'Picnic & On-the-go',
                  'picnic_onthego.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelHouseholdLighting(
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
              _buildGridTile('Household', title, 'Lamps', 'lamps.jpg'),
              _buildGridTile('Household', title, 'Decorative Lighting',
                  'decorative_lighting.jpg'),
              _buildGridTile('Household', title, 'Integrated Lighting',
                  'integrated_lighting.jpg'),
              _buildGridTile(
                  'Household', title, 'Smart Lighting', 'smart_lighting.jpg'),
              _buildGridTile('Household', title, 'Outdoor Lighting',
                  'outdoor_lighting.jpg'),
              _buildGridTile('Household', title, 'Bathroom Lighting',
                  'bathroom_lighting.jpg'),
              _buildGridTile(
                  'Household', title, 'LED Light Bulbs', 'led_light_bulbs.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelHouseholdKitchen(
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
              _buildGridTile('Household', title, 'Kitchen Cabinets',
                  'kitchen_cabinets.jpg'),
              _buildGridTile(
                  'Household', title, 'Kitchen Doors', 'kitchen_doors.jpg'),
              _buildGridTile('Household', title, 'Kitchen Appliances',
                  'kitchen_appliances.jpg'),
              _buildGridTile('Household', title, 'Kitchen Worktops',
                  'kitchen_worktops.jpg'),
              _buildGridTile('Household', title, 'Kitchen Taps & Sinks',
                  'kitchen_taps_sinks.jpg'),
              _buildGridTile(
                  'Household',
                  title,
                  'Kitchen Wall Storage & Organisers',
                  'kitchen_wall_storage_organisers.jpg'),
              _buildGridTile(
                  'Household', title, 'Knobs & Handles', 'knobs_handles.jpg'),
              _buildGridTile('Household', title, 'Kitchen Lighting',
                  'kitchen_lighting.jpg'),
              _buildGridTile(
                  'Household',
                  title,
                  'Kitchen Splashbacks & Wall Panels',
                  'kitchen_splashbacks_wall_panels.jpg'),
              _buildGridTile(
                  'Household', title, 'Kitchenettes', 'kitchenettes.jpg'),
              _buildGridTile('Household', title, 'Pantry', 'pantry.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelHouseholdPlants(
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
                  'Household', title, 'Plants & Flowers', 'plants_flowers.jpg'),
              _buildGridTile('Household', title, 'Flower Pots & Planters',
                  'flower_pots_planters.jpg'),
              _buildGridTile('Household', title, 'Plant Stands & Movers',
                  'plant_stands_movers.jpg'),
              _buildGridTile('Household', title, 'Growing Accessories',
                  'growing_accessories.jpg'),
              _buildGridTile(
                  'Household', title, 'Watering Cans', 'watering_cans.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  Widget _buildExpansionListElectronics(
    String title,
  ) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(10),
        child: ExpansionPanelList(
          animationDuration: Duration(milliseconds: 250),
          children: [
            _buildExpansionPanelElectronicsHouseholdAppliances(
                'Household Appliances', _expanded),
            _buildExpansionPanelElectronicsPhone(
                'Phone,Tablet,Smartwatch', _expanded2),
            _buildExpansionPanelElectronicsTV(
                'TV, Audio, Game console', _expanded3),
            _buildExpansionPanelElectronicsSmall(
                'Small household appliances', _expanded4),
            _buildExpansionPanelElectronicsComputing(
                'Computing, Gamer', _expanded5),
            _buildExpansionPanelElectronicsPhoto(
                'Photo, Video, Optics', _expanded6),
            _buildExpansionPanelElectronicsGarden(
                'Garden, DIY, Car equipment', _expanded7),
            _buildExpansionPanelElectronicsGame(
                'Game, Sport, Leisure', _expanded8),
            _buildExpansionPanelElectronicsAtHome('At home', _expanded9),
            _buildExpansionPanelElectronicsBabyMama('Baby, Mom', _expanded10),
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
                _expanded6 = false;
                _expanded7 = false;
                _expanded8 = false;
                _expanded9 = false;
                _expanded10 = false;
              } else if (panelIndex == 1) {
                _expanded = false;
                _expanded2 = !_expanded2;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = false;
                _expanded6 = false;
                _expanded7 = false;
                _expanded8 = false;
                _expanded9 = false;
                _expanded10 = false;
              } else if (panelIndex == 2) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = !_expanded3;
                _expanded4 = false;
                _expanded5 = false;
                _expanded6 = false;
                _expanded7 = false;
                _expanded8 = false;
                _expanded9 = false;
                _expanded10 = false;
              } else if (panelIndex == 3) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = !_expanded4;
                _expanded5 = false;
                _expanded6 = false;
                _expanded7 = false;
                _expanded8 = false;
                _expanded9 = false;
                _expanded10 = false;
              } else if (panelIndex == 4) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = !_expanded5;
                _expanded6 = false;
                _expanded7 = false;
                _expanded8 = false;
                _expanded9 = false;
                _expanded10 = false;
              } else if (panelIndex == 5) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = false;
                _expanded6 = !_expanded6;
                _expanded7 = false;
                _expanded8 = false;
                _expanded9 = false;
                _expanded10 = false;
              } else if (panelIndex == 6) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = false;
                _expanded6 = false;
                _expanded7 = !_expanded7;
                _expanded8 = false;
                _expanded9 = false;
                _expanded10 = false;
              } else if (panelIndex == 7) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = false;
                _expanded6 = false;
                _expanded7 = false;
                _expanded8 = !_expanded8;
                _expanded9 = false;
                _expanded10 = false;
              } else if (panelIndex == 8) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = false;
                _expanded6 = false;
                _expanded7 = false;
                _expanded8 = false;
                _expanded9 = !_expanded9;
                _expanded10 = false;
              } else if (panelIndex == 9) {
                _expanded = false;
                _expanded2 = false;
                _expanded3 = false;
                _expanded4 = false;
                _expanded5 = false;
                _expanded6 = false;
                _expanded7 = false;
                _expanded8 = false;
                _expanded9 = false;
                _expanded10 = !_expanded10;
              }
            });
          },
        ),
      ),
    ]);
  }

  ExpansionPanel _buildExpansionPanelElectronicsHouseholdAppliances(
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
              _buildGridTile('Electronics', title, 'Washing Machines',
                  'washing_machines.jpg'),
              _buildGridTile('Electronics', title, 'Dryers', 'dryers.jpg'),
              _buildGridTile(
                  'Electronics', title, 'Dishwashers', 'dishwashers.jpg'),
              _buildGridTile(
                  'Electronics', title, 'Refrigerators', 'refrigerators.jpg'),
              _buildGridTile('Electronics', title, 'Freezers', 'freezers.jpg'),
              _buildGridTile('Electronics', title, 'Stoves', 'stoves.jpg'),
              _buildGridTile('Electronics', title, 'Built-in Devices',
                  'built_in_devices.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelElectronicsPhone(
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
              _buildGridTile('Electronics', title, 'Phones', 'phones.jpg'),
              _buildGridTile('Electronics', title, 'Smart Watch, Bracelet',
                  'smart_watch_bracelet.jpg'),
              _buildGridTile('Electronics', title, 'Tablets, E-Book Readers',
                  'tablets_ebook_readers.jpg'),
              _buildGridTile('Electronics', title, 'Accessories',
                  'electronics_accessories.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelElectronicsTV(
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
              _buildGridTile('Electronics', title, 'Televisions',
                  'televesions & accessories.jpg'),
              _buildGridTile('Electronics', title, 'Audio', 'audio.jpg'),
              _buildGridTile(
                  'Electronics', title, 'Game Consoles', 'game_consoles.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelElectronicsSmall(
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
              _buildGridTile('Electronics', title, 'Coffee', 'coffee.jpg'),
              _buildGridTile(
                  'Electronics', title, 'Floor Care', 'floor_care.jpg'),
              _buildGridTile('Electronics', title, 'Food Preparation',
                  'food_preparation.jpg'),
              _buildGridTile(
                  'Electronics', title, 'Beauty Care', 'beauty_care.jpg'),
              _buildGridTile(
                  'Electronics', title, 'Baking Cooking', 'baking_cooking.jpg'),
              _buildGridTile('Electronics', title, 'Microwave Ovens',
                  'microwave_ovens.jpg'),
              _buildGridTile(
                  'Electronics', title, 'Oral Care', 'oral_care.jpg'),
              _buildGridTile('Electronics', title, 'Health Preservation',
                  'health_preservation.jpg'),
              _buildGridTile(
                  'Electronics', title, 'Clothes Care', 'clothes_care.jpg'),
              _buildGridTile('Electronics', title, 'Air Conditioners',
                  'air_conditioners.jpg'),
              _buildGridTile(
                  'Electronics', title, 'Soda Machines', 'soda_machines.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelElectronicsComputing(
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
              _buildGridTile('Electronics', title, 'Computer Technology',
                  'computer_technology.jpg'),
              _buildGridTile(
                  'Electronics', title, 'Peripherals', 'peripherals.jpg'),
              _buildGridTile('Electronics', title, 'Computer Accessories',
                  'notebook_computer_accessories.jpg'),
              _buildGridTile('Electronics', title, 'Home Automation',
                  'home_automation.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelElectronicsPhoto(
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
              _buildGridTile('Electronics', title, 'Photo', 'photo.jpg'),
              _buildGridTile('Electronics', title, 'Camera', 'camera.jpg'),
              _buildGridTile('Electronics', title, 'Photo & Video Accessories',
                  'photo_video_accessories.jpg'),
              _buildGridTile('Electronics', title, 'Nature Observation',
                  'nature_observation.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelElectronicsGarden(
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
                  'Electronics', title, 'DIY Machines', 'diy_machines.jpg'),
              _buildGridTile('Electronics', title, 'Tools, Measurement',
                  'tools_storage_measurement.jpg'),
              _buildGridTile('Electronics', title, 'Cleaning Machines',
                  'cleaning_machines.jpg'),
              _buildGridTile('Electronics', title, 'Garden Machines',
                  'garden_machines.jpg'),
              _buildGridTile(
                  'Electronics', title, 'Garden Tools', 'garden_tools.jpg'),
              _buildGridTile('Electronics', title, 'Water Technology',
                  'water_technology.jpg'),
              _buildGridTile('Electronics', title, 'Grill,Pool,Garden',
                  'grill_pool_garden.jpg'),
              _buildGridTile('Electronics', title, 'Vehicles & Accessories',
                  'vehicles_accessories.jpg'),
              _buildGridTile(
                  'Electronics', title, 'Navigation', 'navigation.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelElectronicsGame(
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
              _buildGridTile('Electronics', title, 'Leisure Time, Sports',
                  'leisure_time_sports.jpg'),
              _buildGridTile('Electronics', title, 'Game', 'gaming.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelElectronicsAtHome(
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
                  'Electronics', title, 'Home Products', 'home_products.jpg'),
              _buildGridTile(
                  'Electronics', title, 'Furnitures', 'furnitures.jpg'),
              _buildGridTile('Electronics', title, 'Lighting', 'lighting.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
  }

  ExpansionPanel _buildExpansionPanelElectronicsBabyMama(
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
              _buildGridTile('Electronics', title, 'Baby Care', 'baby_mom.jpg'),
            ],
          ),
        ],
      ),
      isExpanded: expanded,
      canTapOnHeader: true,
    );
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
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage(
                        'images/${image}',
                      )),
                ),
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
        centerTitle: true,
        title: Text(
          'Select Category',
          style: TextStyle(color: mainColor),
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
          SingleChildScrollView(
            child: Column(
              children: [
                _buildExpansionListHousehold('Household'),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                _buildExpansionListElectronics('Electronics'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
