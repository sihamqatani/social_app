import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData themeApp = ThemeData(
    primarySwatch: Colors.deepOrange,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.deepOrange,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.grey),
        backwardsCompatibility: false,
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        selectedItemColor: Colors.amber[900],
        unselectedItemColor: Colors.grey),
    textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        subtitle1: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          //  height: 1.3
          //fontFamily: 'jannah'
        ),
        subtitle2: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            fontFamily: 'jannah')));
ThemeData darkThemeApp = ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch: Colors.deepOrange,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  )),
  appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      backwardsCompatibility: false,
      backgroundColor: HexColor('333739'),
      elevation: 0,
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      )),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: HexColor('333739'),
      elevation: 20,
      selectedItemColor: Colors.amber[900],
      unselectedItemColor: Colors.grey),
);
