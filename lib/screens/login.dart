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
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = RegExp(pattern);
bool obserText = true;

String? email;
String? password;

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

Color mainColor = const Color.fromARGB(255, 255, 115, 0);

class _LoginState extends State<Login> {
  void validation() async {
    final FormState? _form = _formKey.currentState;
    if (!_form!.validate()) {
      try {
        UserCredential result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email!, password: password!);
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
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 200,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close))),
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
                              border: OutlineInputBorder(),
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.black)),
                        ),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              password = value;
                              // print(email);
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
                              border: OutlineInputBorder(),
                              hintText: 'Password',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    FocusScope.of(context).unfocus();
                                    obserText = !obserText;
                                  });
                                },
                                child: Icon(
                                  obserText == true
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                              ),
                              hintStyle: TextStyle(color: Colors.black)),
                        ),
                        Center(
                          child: Container(
                            width: 200,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor),
                              onPressed: () {
                                validation();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TabsWithScreens()));
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
      ),
    );
  }
}
