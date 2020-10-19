import 'package:flutter/material.dart';

class Const {
  /// --------------
  /// Constant Color
  /// --------------
  static Color primaryColor = Color(0xff00D070);
  static Color lightPrimaryColor = Color(0xff00B28B);
  static Color blackColor = Color(0xff666666);
  static Color grayColor = Color(0xff999999);
  static Color graySoftColor = Color(0xffF6F6F6);

  /// --------------
  /// Screen
  /// --------------
  static screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.height;

  /// --------------
  /// TextStyle
  /// --------------
  /// TextStyle styleHeader = TextStyle(
  static TextStyle styleHeader = TextStyle(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w700,
  );

  static TextStyle styleTitle = TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w700,
  );

  static TextStyle styleSubTitle = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );
}
