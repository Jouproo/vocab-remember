import 'package:flutter/material.dart';

const kPrimaryColor = 0xFF42A5F5;
const kDismissColor = Colors.red;
const kLightBlack = Colors.black54;
const iconGray = Colors.grey;
const kSmallTextStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w400,
  fontSize: 14.0,
  color: Color(kPrimaryColor),
);

const kAppBarStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w700,
  fontSize: 32.0,
);

const kLargeTextStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w500,
  fontSize: 18.0,
  color: Color(kPrimaryColor),
);

const kCustomCardWordTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 17.0,
  fontFamily: 'Montserrat',


);

const kBackgroundColor =Colors.grey;
//Color(0xffbbd5d5);

const kMeaningTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 21,
    color: Colors.black);

const kCardTextStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 22.0,
  fontWeight: FontWeight.w600,
  color: Colors.black
  //Color(kPrimaryColor),
);

const wCardTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    color: Colors.white
  //Color(kPrimaryColor),
);

String capitalize(String word) {
  return word[0].toUpperCase() + word.substring(1);
}


String ? uId = '';