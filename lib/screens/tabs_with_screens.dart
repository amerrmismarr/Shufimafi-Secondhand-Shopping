import 'package:dolabi/screens/favorites.dart';
import 'package:dolabi/screens/new_product.dart';
import 'package:dolabi/screens/notifications.dart';
import 'package:dolabi/screens/profile.dart';
import 'package:dolabi/screens/search.dart';
import 'package:dolabi/screens/selling_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'home.dart';
import 'login.dart';

class TabsWithScreens extends StatefulWidget {
  //StreamSubscription _userSubscription;
  @override
  _TabsWithScreensState createState() => _TabsWithScreensState();

  static TabBar get tabBar {
    Color mainColor = Color.fromARGB(255, 240, 149, 92);
    return TabBar(
        indicatorColor: mainColor,
        unselectedLabelColor: mainColor,
        labelColor: Colors.black,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: mainColor),
        tabs: <Widget>[
          new Tab(
            icon: new Icon(Icons.home),
          ),
          new Tab(icon: new Icon(Icons.favorite_border)),
          new Tab(icon: new Icon(Icons.add_box_rounded)),
          new Tab(icon: new Icon(Icons.notifications_none)),
          new Tab(icon: new Icon(Icons.person)),
        ]);
  }
}

class _TabsWithScreensState extends State<TabsWithScreens>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  late ScrollController scrollController;

  bool isVisible = true;
  PersistentTabController? _controller;

  Color mainColor = const Color.fromARGB(255, 255, 115, 0);

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    controller = new TabController(vsync: this, length: 5, initialIndex: 2);
    scrollController = ScrollController();
    scrollController.addListener(listen);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    scrollController.removeListener(listen);
    super.dispose();
  }

  void listen() {
    final direction = scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  void show() {
    if (!isVisible)
      setState(() {
        isVisible = true;
      });
  }

  void hide() {
    if (isVisible)
      setState(() {
        isVisible = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
          backgroundColor: Colors.grey[50],
          /*bottomNavigationBar: AnimatedBuilder(
            animation: scrollController,
            builder: (context, child) {
              if (scrollController.hasClients) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: isVisible ? 50 : 0,
                  child: child,
                );
              }
              return _navBarsItems()
            },
            child: Wrap(children: [TabsWithScreens.tabBar]),
          ),*/
          body: PersistentTabView(context,
              hideNavigationBar: isVisible ? false : true,
              controller: _controller,
              screens: _buildScreens(),
              items: _navBarsItems(),
              confineInSafeArea: true,
              backgroundColor: Colors.white, // Default is Colors.white.
              handleAndroidBackButtonPress: true, // Default is true.
              resizeToAvoidBottomInset:
                  true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
              stateManagement: true, // Default is true.
              hideNavigationBarWhenKeyboardShows:
                  true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
              decoration: NavBarDecoration(
                borderRadius: BorderRadius.circular(10.0),
                colorBehindNavBar: Colors.white,
              ),
              popAllScreensOnTapOfSelectedTab: true,
              popActionScreens: PopActionScreensType.all,
              itemAnimationProperties: ItemAnimationProperties(
                // Navigation Bar's items animation properties.
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
              ),
              screenTransitionAnimation: ScreenTransitionAnimation(
                // Screen transition animation on change of selected tab.
                animateTabTransition: true,
                curve: Curves.ease,
                duration: Duration(milliseconds: 200),
              ),
              navBarStyle: NavBarStyle.style15)),
    );
  }

  List<Widget> _buildScreens() {
    return [
      Home(
        scrollController: scrollController,
      ),

      Search(),
      SellingInformation(),
      Favorites(),
      Notifications(),
//Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.home),
          title: ("Home"),
          activeColorPrimary: mainColor,
          inactiveColorPrimary: Color.fromARGB(255, 255, 203, 125)),
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.search),
          title: ('Search'),
          activeColorPrimary: mainColor,
          inactiveColorPrimary: Color.fromARGB(255, 255, 203, 125)),
      PersistentBottomNavBarItem(
          icon: Icon(
            CupertinoIcons.add,
            color: Colors.white,
          ),
          title: ("Sell"),
          activeColorPrimary: mainColor,
          inactiveColorPrimary: Color.fromARGB(255, 255, 203, 125)),
      PersistentBottomNavBarItem(
          icon: Icon(
            CupertinoIcons.heart,
          ),
          title: ("Favorites"),
          activeColorPrimary: mainColor,
          inactiveColorPrimary: Color.fromARGB(255, 255, 203, 125)),
      PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.bell),
          title: ("Notifications"),
          activeColorPrimary: mainColor,
          inactiveColorPrimary: Color.fromARGB(255, 255, 203, 125)),
      /*   PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.profile_circled),
          title: ('Profile'),
          activeColorPrimary: mainColor,
          inactiveColorPrimary: mainColor),*/
    ];
  }
}
