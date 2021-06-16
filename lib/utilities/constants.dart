import 'package:flutter/material.dart';

const kDataTextStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w400,
);

const kButtonTextStyle = TextStyle(
  fontSize: 18.0,
  color: Colors.white,
);

const kDivider = Divider(
  height: 1.0,
  color: Colors.grey,
);

const kAppBarTextStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.w700,
);

const kInputTextField = InputDecoration(
  hintText: 'Email goes here...',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
);

const kTokenContainer = BoxDecoration(
  color: Color(0xffF0F0F0),
  borderRadius: BorderRadius.all(Radius.circular(8.0)),
);

const kTokenTextStyle = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
);

const kWelcomeTextStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w700,
);

const kMainBackgroundColor = Colors.white;
