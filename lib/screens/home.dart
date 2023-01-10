import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dolabi/screens/drawer.dart';
import 'package:dolabi/screens/home_logged_in.dart';
import 'package:dolabi/screens/home_not_logged_in.dart';
import 'package:dolabi/screens/product_details.dart';
import 'package:dolabi/screens/profile.dart';
import 'package:dolabi/screens/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../services/local_notifications_service.dart';
import 'login.dart';

class Home extends StatefulWidget {
  ScrollController? scrollController;

  Home({this.scrollController});

  @override
  State<Home> createState() => _HomeState(scrollController);
}

class _HomeState extends State<Home> {
  ScrollController? scrollController;
  _HomeState(this.scrollController);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String searchingText = 'Search.......';

  Color mainColor = const Color.fromARGB(255, 255, 115, 0);

  storeNotificationToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'Token': token}, SetOptions(merge: true));
  }

  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      storeNotificationToken();
    }
    // TODO: implement initState
    super.initState();
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        iconSize: 30,
        icon: const Icon(Icons.manage_search),
        onPressed: () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: DrawerWidget(
              onSearchResult: (String searchText) {
                setState(() {
                  searchingText = searchText;
                });
              },
            ),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.slideRight,
          );
        },
      ),
      actions: [
        IconButton(
            onPressed: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: Profile(),
                withNavBar: true,
              );
            },
            icon: Icon(Icons.person))
      ],
      title: Container(
          height: 70,
          width: 70,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('images/logo.png')))),
      iconTheme: IconThemeData(color: mainColor),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();

    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        drawer: DrawerWidget(
          onSearchResult: (String searchText) {
            setState(() {
              searchingText = searchText;
            });
          },
        ),
        appBar: _buildAppBar(),
        body: StreamBuilder<User?>(
            initialData: FirebaseAuth.instance.currentUser,
            stream: FirebaseAuth.instance.userChanges(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return HomeLoggedIn(
                  scrollController: scrollController,
                );
              }
              return HomeNotLoggedIn(
                scrollController: scrollController,
              );
            }));
  }
}
