import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFFFF4C3B);
const Color kScaffoldBackgroundColor = Color(0xFFFFFFFF);

const Color successColor = Colors.green;
const Color failedColor = Colors.red;
const Color warningColor = Colors.orange;

const Color kWhite = Colors.white;
const Color kGreen = Color(0xFF1CAF5E);

const Color kRed = Colors.red;
const Color kRedDeep = Color(0xFFF71B24);

const Color kBlack = Colors.black;
const Color kBlackLight = Color(0xFF222222);

const Color kGrey = Color(0xFF777777);
const Color kGreyLight = Color(0xFFEDEFF4);

const Color kOrange = Color(0xFFFFA800);
const Color kDeepOrange = Color(0xFFFF5F2D);

const Color kShimmerBaseColor = Color(0xFFE0E0E0);
const Color kShimmerHighlightColor = Color(0xFFF5F5F5);

const List<Color> randomColors = [
  Colors.deepOrange,
  Colors.blue,
  Colors.green,
  Colors.teal,
  Colors.purple,
];

const Map<int, Color> materialColor = {
  50: Color.fromRGBO(255, 76, 59, .1),
  100: Color.fromRGBO(255, 76, 59, .2),
  200: Color.fromRGBO(255, 76, 59, .3),
  300: Color.fromRGBO(255, 76, 59, .4),
  400: Color.fromRGBO(255, 76, 59, .5),
  500: Color.fromRGBO(255, 76, 59, .6),
  600: Color.fromRGBO(255, 76, 59, .7),
  700: Color.fromRGBO(255, 76, 59, .8),
  800: Color.fromRGBO(255, 76, 59, .9),
  900: Color.fromRGBO(255, 76, 59, 1),
};

const MaterialColor kPrimarySwatchColor = MaterialColor(
  0xFFFF4C3B,
  materialColor,
);
