import 'package:flutter/material.dart';

import '../constants/fixed_constants.dart';
import 'swatch.dart';

class AppTheme {
  static ThemeData apptheme() => ThemeData(
      fontFamily: 'Poppins',
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(smallBorderRadius)))),
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(
            color: Colors.black,
            size: 30,
          )),
      primaryColor: bluePrimary,
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: bluePrimary,
          onPrimary: Colors.white,
          secondary: errorOrange,
          onSecondary: Colors.white,
          error: errorOrange,
          onError: Colors.black87,
          background: backgroundDullWhite,
          onBackground: Colors.black,
          surface: surfacePurpleColor,
          onSurface: Colors.black),
      primarySwatch: generateMaterialColor(bluePrimary),
      scaffoldBackgroundColor: Colors.white,
      navigationBarTheme:
          const NavigationBarThemeData(backgroundColor: Colors.amber));
}

var cursorColor = Colors.blueGrey;
var bluePrimary = const Color(0xFF61C3F2);
var darkPurple = const Color(0xff2E2739);
var darkPurplePrimary = const Color.fromARGB(255, 15, 87, 188);
var lightOrangesecondary = const Color(0xFFF4B942);
var errorOrange = const Color(0xFFF5811F);
var backgroundDullWhite = const Color.fromARGB(255, 234, 247, 242);
var surfacePurpleColor = const Color.fromARGB(255, 168, 169, 245);
