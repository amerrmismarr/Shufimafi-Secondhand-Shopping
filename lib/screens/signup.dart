import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dolabi/screens/home.dart';
import 'package:dolabi/screens/login.dart';
import 'package:dolabi/screens/tabs_with_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validator/form_validator.dart';

import '../widgets/change_screen.dart';
import '../widgets/mybutton.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

String pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = RegExp(pattern);
bool obserText = true;

GlobalKey<FormState> _formSU = GlobalKey<FormState>();

String? email;
String? password;
String? firstName;
String? lastName;
String? phoneNumber;

class _SignUpState extends State<SignUp> {
  void validation() async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      FirebaseFirestore.instance
          .collection('Users')
          .doc(result.user!.uid.toString())
          .set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
        'favorites': [],
        'followList': []
      }).whenComplete(() => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => TabsWithScreens())));
      print(result.user!.uid);
    } on FirebaseAuthException catch (e) {
      print(e.message.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  void _validate() {
    _formSU.currentState!.validate();
  }

  _createAlertDialog(String error) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                error,
                style: TextStyle(color: mainColor),
              ),
              icon: Icon(
                Icons.error,
                color: mainColor,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                color: mainColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close))
          ],
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: Form(
          key: _formSU,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(children: <Widget>[
              Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/logo.png')))),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator:
                    ValidationBuilder(requiredMessage: 'This field is required')
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
                decoration: const InputDecoration(
                    labelText: "First name",
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
                decoration: const InputDecoration(
                    labelText: "Last name",
                    labelStyle: TextStyle(color: Colors.black),
                    hintStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: ValidationBuilder().email().maxLength(50).build(),
                onChanged: (value) {
                  setState(() {
                    email = value;
                    // print(email);
                  });
                },
                scrollPadding: EdgeInsets.only(bottom: 40),
                decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.black),
                    hintStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              TextFormField(
                validator:
                    ValidationBuilder().minLength(8).maxLength(50).build(),
                onChanged: (value) {
                  setState(() {
                    password = value;
                    // print(email);
                  });
                },
                obscureText: obserText,
                scrollPadding: EdgeInsets.only(bottom: 40),
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          obserText = !obserText;
                        });
                        FocusScope.of(context).unfocus();
                      },
                      child: Icon(
                        obserText == true
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.black),
                    hintStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder()),
              ),
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
                decoration: const InputDecoration(
                    labelText: "Phone Number",
                    labelStyle: TextStyle(color: Colors.black),
                    hintStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                    onPressed: () {
                      _validate();
                      if (_formSU.currentState!.validate()) {
                        validation();
                      }
                    },
                    // validation();

                    child: Text('Register'),
                  ),
                ),
              ),
            ]),
          ),
        )));
  }
}
