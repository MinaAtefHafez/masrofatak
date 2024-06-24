import 'package:flutter/material.dart';

abstract class AppTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        )),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
      elevation: 5,
    ),
     fontFamily: 'Inter' 
  );


  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        )),
    floatingActionButtonTheme:  FloatingActionButtonThemeData(
      backgroundColor: Colors.grey.shade300,
      elevation: 5,
    ),
    fontFamily: 'Inter' 
  );
}
