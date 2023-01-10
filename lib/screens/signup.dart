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

import '../widgets/change_screen.dart';
import '../widgets/mybutton.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

String pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = RegExp(pattern);
bool obserText = true;

String? email;
String? password;
String? username;
String? phoneNumber;

class _SignUpState extends State<SignUp> {
  void validation() async {
    final FormState? _form = _formKey.currentState;
    if (!_form!.validate()) {
      try {
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);
        FirebaseFirestore.instance
            .collection('Users')
            .doc(result.user!.uid.toString())
            .set({
          'Username': username,
          'Email': email,
          'phoneNumber': phoneNumber,
          'Password': password,
          'favorites': [],
          'followList': []
        });
        print(result.user!.uid);
      } on FirebaseAuthException catch (e) {
        print(e.message.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message!),
          ),
        );
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
              textAlign: TextAlign.end,
            ),
          ),
        );
      }
    } else {
      print('No');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 150,
                  //color: const Color.fromRGBO(131, 13, 65, 1),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(Icons.close))),
                        Text(
                          'Register',
                          style: TextStyle(
                              //color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 450,
                  width: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              username = value;
                              // print(email);
                            });
                          },
                          validator: (value) {
                            if (value == '') {
                              return 'Please fill username';
                            } else if (value!.length < 6) {
                              return "Username is too short";
                            }

                            return '';
                          },
                          decoration: const InputDecoration(
                              hintText: "Username",
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder()),
                        ),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              email = value;
                              // print(email);
                            });
                          },
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'Please fill email';
                            } else if (!regExp.hasMatch(value)) {
                              return 'Email is invalid';
                            }

                            return '';
                          },
                          decoration: const InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder()),
                        ),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          obscureText: obserText,
                          validator: (value) {
                            if (value == '') {
                              return 'Please fill password';
                            } else if (value!.length < 8) {
                              return 'Password is too short';
                            }
                            return '';
                          },
                          decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: const TextStyle(color: Colors.black),
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
                              border: const OutlineInputBorder()),
                        ),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              phoneNumber = value;
                              // print(email);
                            });
                          },
                          validator: (value) {
                            if (value == '') {
                              return 'Please fill phone number';
                            } else if (value!.length < 11) {
                              return 'Phone number must be 11';
                            }
                            return '';
                          },
                          decoration: const InputDecoration(
                              hintText: "Phone number",
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder()),
                        ),
                        MyButton(
                          onPressed: () {
                            validation();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => TabsWithScreens()));
                            Fluttertoast.showToast(
                                msg: 'Welcome,' + ' ' + username! + '!',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.teal[200],
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                          name: 'Register',
                        ),
                        ChangeScreen(
                          name: 'Login',
                          whichAccount: 'Already have an account?',
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const Login()));
                          },
                        )
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
