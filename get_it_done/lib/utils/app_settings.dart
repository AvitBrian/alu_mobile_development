import 'package:flutter/material.dart';

class AppSettings {
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static Color primaryColor = Colors.white;
  static Color secondaryColor = Colors.white;
  static Color backgroundColor = Colors.black;
  static Color navColor = Colors.grey.shade800;
  static Color textColor = Colors.white;
}
