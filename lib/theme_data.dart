import 'package:flutter/material.dart';

class MyThemeData {
  static Color primaryLight = const Color(0xFF5D9CEC);
  static Color backGroundLight = const Color(0xFFDEFCDB);
  static Color whiteColor = Colors.white;
  static Color greyLight = const Color(0xFFC8C9CB);
  static Color greenColor = const Color(0xFF61E757);
  static Color redColor = const Color(0xFFE43737);
  static Color blackColor = const Color(0xFF141922);
  static Color backGroundDark = const Color(0xFF060e1e);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryLight,
    appBarTheme: AppBarTheme(
        backgroundColor: primaryLight,
        actionsIconTheme: IconThemeData(color: whiteColor)),
    scaffoldBackgroundColor: backGroundLight,
    textTheme: TextTheme(
      headline1: TextStyle(
          color: whiteColor, fontSize: 22, fontWeight: FontWeight.bold),
      headline2: TextStyle(
          color: primaryLight, fontWeight: FontWeight.bold, fontSize: 26),
      subtitle2: TextStyle(
          color: greenColor, fontWeight: FontWeight.bold, fontSize: 26),
      subtitle1:
          TextStyle(color: redColor, fontWeight: FontWeight.bold, fontSize: 22),
      headline3: TextStyle(
          color: blackColor, fontWeight: FontWeight.bold, fontSize: 22),
      headline4: TextStyle(
          color: greyLight, fontWeight: FontWeight.bold, fontSize: 17),
      headline5: TextStyle(
          color: blackColor, fontWeight: FontWeight.bold, fontSize: 20),
      headline6:
          TextStyle(color: redColor, fontWeight: FontWeight.bold, fontSize: 20),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: Colors.transparent,
        selectedItemColor: primaryLight,
        unselectedItemColor: greyLight),
  );
  static ThemeData darkTheme = ThemeData(
      primaryColor: primaryLight,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryLight,
        actionsIconTheme: IconThemeData(color: blackColor),
        iconTheme: IconThemeData(color: blackColor),
      ),
      scaffoldBackgroundColor: backGroundDark,
      textTheme: TextTheme(
        headline1: TextStyle(
            color: blackColor, fontSize: 22, fontWeight: FontWeight.bold),
        headline2: TextStyle(
            color: primaryLight, fontWeight: FontWeight.bold, fontSize: 22),
        subtitle2: TextStyle(
            color: greenColor, fontWeight: FontWeight.bold, fontSize: 26),
        subtitle1: TextStyle(
            color: redColor, fontWeight: FontWeight.bold, fontSize: 18),
        headline3: TextStyle(
            color: whiteColor, fontWeight: FontWeight.bold, fontSize: 18),
        headline4: TextStyle(
            color: greyLight, fontWeight: FontWeight.bold, fontSize: 17),
        headline5: TextStyle(
            // data select time
            color: whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 20),
        headline6: TextStyle(
            color: redColor, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: primaryLight,
          unselectedItemColor: greyLight));
}
