import 'package:flutter/material.dart';
import 'package:iconnections_challenge/utilities/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Button extends StatelessWidget {
  Button({required this.title, required this.onPressed});

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: Material(
        color: Color(0xff692B7E),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: MaterialButton(
          child: AutoSizeText(
            title,
            style: kButtonTextStyle,
            maxLines: 1,
          ),
          onPressed: onPressed,
          minWidth: 325.0,
          height: 57.0,
        ),
      ),
    );
  }
}
