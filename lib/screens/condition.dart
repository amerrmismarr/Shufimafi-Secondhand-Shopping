import 'package:dolabi/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Condition extends StatefulWidget {
  @override
  State<Condition> createState() => _ConditionState();
}

class _ConditionState extends State<Condition> {
  Widget _createListTile(String condition) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, condition);
      },
      child: ListTile(
        title: Text(
          condition,
          style: TextStyle(fontSize: 13),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 15,
          color: mainColor,
        ),
      ),
    );
  }

  String? condition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          _createListTile('Used'),
          _createListTile('Price Tag On'),
          _createListTile('Used but in good condition'),
        ],
      ),
    );
  }
}
