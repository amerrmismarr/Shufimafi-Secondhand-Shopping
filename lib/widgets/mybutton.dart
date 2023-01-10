import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? name;

  MyButton({this.name, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 240, 149, 92)),
        child: Text(
          name!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
