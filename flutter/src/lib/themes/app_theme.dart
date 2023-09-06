import 'package:flutter/material.dart';

class Apptheme {
  static const Color primary = Color.fromARGB(255, 81, 114, 85);

  static final ThemeData lighTheme = ThemeData.light().copyWith(
    primaryColor: const Color.fromARGB(255, 81, 114, 85),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(255, 81, 114, 85), elevation: 0),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: primary),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: primary)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
    ),
  );
}
