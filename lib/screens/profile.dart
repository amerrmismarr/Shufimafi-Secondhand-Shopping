// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dolabi/screens/favorites.dart';
import 'package:dolabi/screens/tabs_with_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../services/auth_bloc.dart';
import 'login.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color mainColor = const Color.fromARGB(255, 255, 115, 0);
    var authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<User?>(
            initialData: FirebaseAuth.instance.currentUser,
            stream: FirebaseAuth.instance.userChanges(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return const ProfileLoggedIn();
              }
              return const ProfileNotLoggedIn();
            }));
  }
}

class ProfileLoggedIn extends StatefulWidget {
  const ProfileLoggedIn({super.key});

  @override
  State<ProfileLoggedIn> createState() => _ProfileLoggedInState();
}

class _ProfileLoggedInState extends State<ProfileLoggedIn> {
  Color mainColor = const Color.fromARGB(255, 255, 115, 0);
  Widget _buildListTile(IconData iconData, String title, double thickness) {
    return Column(
      children: [
        ListTile(
          leading: Icon(iconData),
          title: Text(
            title,
            style: TextStyle(fontSize: 13),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        Divider(
          thickness: thickness,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          var name = snapshot.data['Username'];

          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: mainColor,
                actions: [
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {},
                  ),
                ],
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.all(3), child: Text('@$name')),
                ),
              ),
              body: ListView(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  const ListTile(
                    leading: CircleAvatar(),
                    title: Text(
                      'My Shufimafi',
                      style: TextStyle(fontSize: 13),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  _buildListTile(Icons.rocket, 'Sales Center', 2),
                  _buildListTile(
                      Icons.stacked_line_chart, 'My Highlight Stats', 2),
                  _buildListTile(Icons.family_restroom, 'Ghurfati Club', 10),
                  _buildListTile(Icons.discount, 'Coupons', 2),
                  _buildListTile(Icons.favorite, 'Favorites', 2),
                  _buildListTile(Icons.local_offer, 'My Brands and Sizes', 2),
                  _buildListTile(Icons.percent, 'Offers', 10),
                  _buildListTile(Icons.support_agent, 'Ghurfati Support', 2),
                  _buildListTile(Icons.feedback, 'Feedback', 10),
                  GestureDetector(
                      onTap: () {
                        authBloc.logout();
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: TabsWithScreens(),
                          withNavBar: false,
                        );
                        //   print(FirebaseAuth.instance.currentUser!.uid);
                      },
                      child: _buildListTile(Icons.logout, 'Logout', 0)),
                ],
              ));
        });
  }
}

class ProfileNotLoggedIn extends StatefulWidget {
  const ProfileNotLoggedIn({super.key});

  @override
  State<ProfileNotLoggedIn> createState() => _ProfileNotLoggedInState();
}

class _ProfileNotLoggedInState extends State<ProfileNotLoggedIn> {
  Color mainColor = const Color.fromARGB(255, 255, 115, 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('images/logo.png')))),
            Center(
              child: Text('Please log in to view your profile'),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                  onPressed: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: Login(),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.slideUp,
                    );
                  },
                  child: Text('Log in'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
