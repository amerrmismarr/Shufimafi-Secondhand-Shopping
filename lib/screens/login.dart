import 'package:dolabi/main.dart';
import 'package:dolabi/screens/home.dart';
import 'package:dolabi/screens/signup.dart';
import 'package:dolabi/screens/social_button.dart';
import 'package:dolabi/screens/tabs_with_screens.dart';
import 'package:dolabi/widgets/change_screen.dart';
import 'package:dolabi/widgets/mybutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_validator/form_validator.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

String pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = RegExp(pattern);
bool obserText = true;

String? email;
String? password;

Color mainColor = const Color.fromARGB(255, 255, 115, 0);

GlobalKey<FormState> _formLI = GlobalKey<FormState>();

class _LoginState extends State<Login> {
  void validation() async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!)
          .whenComplete(() => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => TabsWithScreens())));
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
  }

  void _validate() {
    _formLI.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: Form(
        key: _formLI,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: <Widget>[
              Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/logo.png')))),
              Container(
                height: 400,
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
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
                        decoration: const InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(color: Colors.black),
                            hintStyle: TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(),
                            border: OutlineInputBorder()),
                      ),
                      TextFormField(
                        validator: ValidationBuilder()
                            .minLength(8)
                            .maxLength(50)
                            .build(),
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
                      Center(
                        child: Container(
                          width: 200,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor),
                            onPressed: () {
                              _validate();
                              if (_formLI.currentState!.validate()) {
                                validation();
                              }
                              // validation();
                              // Navigator.of(context).pushReplacement(
                              //     MaterialPageRoute(
                              //         builder: (context) => TabsWithScreens()));
                            },
                            child: Text('Log in'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppSocialButton(socialType: SocialType.Facebook),
                            SizedBox(
                              width: 15.0,
                            ),
                            AppSocialButton(
                              socialType: SocialType.Google,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      ChangeScreen(
                        name: 'Sign Up',
                        whichAccount: 'Don\'t have an account?',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SignUp()));
                        },
                      ),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
