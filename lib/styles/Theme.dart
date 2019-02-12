import 'package:flutter/material.dart';

const bgColor = const Color(0xff111111);

final ThemeData baseTheme = ThemeData.dark();

final ThemeData darkTheme = baseTheme.copyWith(
  backgroundColor: bgColor,
  scaffoldBackgroundColor: bgColor,
  accentColor: Colors.grey,
  textTheme: _buidlDarkTextTheme(baseTheme.textTheme),
  primaryTextTheme: _buidlDarkTextTheme(baseTheme.primaryTextTheme),
  accentTextTheme: _buidlDarkTextTheme(baseTheme.accentTextTheme),
);

TextTheme _buidlDarkTextTheme(TextTheme base) {
  return base.copyWith(
      body1: TextStyle(
        fontSize: 16.0,
        color: Colors.white70,
//      height: 1.5,
      ),
      caption: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
      ),
      headline: TextStyle(
        color: Colors.white,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
      subhead: TextStyle(
        color: Colors.white,
      ));
}
