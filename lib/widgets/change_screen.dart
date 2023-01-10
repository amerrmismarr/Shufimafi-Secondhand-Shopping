import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../screens/signup.dart';

class ChangeScreen extends StatelessWidget {
  final String? whichAccount;
  final Function()? onTap;
  final String? name;
  Color mainColor = const Color.fromARGB(255, 255, 115, 0);

  ChangeScreen({this.name, this.onTap, this.whichAccount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(whichAccount!),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(name!,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: mainColor)),
        )
      ],
    );
  }
}
