import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppSocialButton extends StatelessWidget {
  final SocialType? socialType;
  final VoidCallback? onPressed;

  AppSocialButton({@required this.socialType, this.onPressed});
  @override
  Widget build(BuildContext context) {
    Color buttonColor;
    Color iconColor;
    IconData icon;

    switch (socialType) {
      case SocialType.Facebook:
        iconColor = Colors.white;
        buttonColor = Color.fromARGB(255, 0, 38, 70);
        icon = FontAwesomeIcons.facebookF;
        break;
      case SocialType.Google:
        iconColor = Colors.white;
        buttonColor = Color.fromARGB(255, 248, 17, 0);
        icon = FontAwesomeIcons.google;
        break;
      default:
        iconColor = Colors.white;
        buttonColor = Color.fromARGB(255, 0, 38, 70);
        icon = FontAwesomeIcons.facebookF;
    }
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(25),
            //  boxShadow: BaseStyles.boxShawdow,
          ),
          child: Icon(
            icon,
            color: iconColor,
          )),
    );
  }
}

enum SocialType { Facebook, Google }
