import 'package:dolabi/screens/new_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'login.dart';

class SellingInformation extends StatefulWidget {
  const SellingInformation({super.key});

  @override
  State<SellingInformation> createState() => _SellingInformationState();
}

class _SellingInformationState extends State<SellingInformation> {
  @override
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
            Container(
              height: 150,
              width: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: mainColor, width: 1)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 40,
                              width: 80,
                              child: Center(
                                  child: Text(
                                'Products sold',
                                textAlign: TextAlign.center,
                              ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 8),
                          child: Container(
                              width: 80,
                              child: Center(
                                  child: Text(
                                '-',
                                style: TextStyle(fontSize: 30),
                                textAlign: TextAlign.center,
                              ))),
                        )
                      ],
                    ),
                    Container(
                      color: Colors.black,
                      height: 100,
                      width: 1,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 40,
                              width: 80,
                              child: Center(
                                  child: Text(
                                'Products seen',
                                textAlign: TextAlign.center,
                              ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 8),
                          child: Container(
                              width: 80,
                              child: Center(
                                  child: Text(
                                '-',
                                style: TextStyle(fontSize: 30),
                                textAlign: TextAlign.center,
                              ))),
                        )
                      ],
                    ),
                    Container(
                      color: Colors.black,
                      height: 100,
                      width: 1,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 40,
                              width: 80,
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Text('Your  rating'))),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 8),
                          child: Container(
                              width: 80,
                              child: Center(
                                  child: Text(
                                '-',
                                style: TextStyle(fontSize: 30),
                                textAlign: TextAlign.center,
                              ))),
                        )
                      ],
                    )
                  ]),
            ),
            SizedBox(
              height: 30,
            ),
            StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      child: Container(
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor),
                          onPressed: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: NewProduct(),
                              withNavBar: true,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.slideUp,
                            );
                          },
                          child: Text('Sell a product'),
                        ),
                      ),
                    );
                  }

                  return Center(
                    child: Container(
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor),
                        onPressed: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: Login(),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.slideUp,
                          );
                        },
                        child: Text('Sell a product'),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
