// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dolabi/screens/favorites.dart';
import 'package:dolabi/screens/tabs_with_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_validator/form_validator.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../services/auth_bloc.dart';
import 'login.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  Color mainColor = const Color.fromARGB(255, 255, 115, 0);
  Widget _buildListTile(IconData iconData, String title, double thickness) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            iconData,
            color: mainColor,
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 13),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: mainColor,
          ),
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
          var firstName = snapshot.data['firstName'];
          var lastName = snapshot.data['lastName'];
          var email = snapshot.data['email'];
          var phoneNumber = snapshot.data['phoneNumber'];

          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
                elevation: 0.0,
                iconTheme: IconThemeData(color: mainColor),
                backgroundColor: Colors.white,
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.all(3),
                      child: Text(
                        'Welcome, ' + firstName + ' ' + lastName,
                        style: TextStyle(color: mainColor),
                      )),
                ),
              ),
              body: ListView(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: ValidationBuilder(
                            requiredMessage: 'This field is required')
                        .minLength(
                            3, 'This field must be at least 3 characters long')
                        .maxLength(50)
                        .build(),
                    onChanged: (value) {
                      setState(() {
                        firstName = value;
                        // print(email);
                      });
                    },
                    scrollPadding: EdgeInsets.only(bottom: 40),
                    decoration: InputDecoration(
                        hintText: firstName,
                        labelStyle: TextStyle(color: Colors.black),
                        hintStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator:
                        ValidationBuilder().minLength(5).maxLength(50).build(),
                    onChanged: (value) {
                      setState(() {
                        lastName = value;
                        // print(email);
                      });
                    },
                    scrollPadding: EdgeInsets.only(bottom: 40),
                    decoration: InputDecoration(
                        hintText: lastName,
                        labelStyle: TextStyle(color: Colors.black),
                        hintStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator:
                        ValidationBuilder().email().maxLength(50).build(),
                    onChanged: (value) {
                      setState(() {
                        email = value;
                        // print(email);
                      });
                    },
                    scrollPadding: EdgeInsets.only(bottom: 40),
                    decoration: InputDecoration(
                        hintText: email,
                        labelStyle: TextStyle(color: Colors.black),
                        hintStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: ValidationBuilder()
                        .minLength(10)
                        .maxLength(10)
                        .phone()
                        .build(),
                    onChanged: (value) {
                      setState(() {
                        phoneNumber = value;
                        // print(email);
                      });
                    },
                    scrollPadding: EdgeInsets.only(bottom: 40),
                    decoration: InputDecoration(
                        hintText: phoneNumber,
                        labelStyle: TextStyle(color: Colors.black),
                        hintStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder()),
                  ),
                ],
              ));
        });
  }
}
