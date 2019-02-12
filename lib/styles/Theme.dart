import 'package:flutter/material.dart';

final ThemeData darkTheme = _buildDarkTheme(ThemeData.dark());

ThemeData _buildDarkTheme(ThemeData baseTheme) {
  final _bgColor = const Color(0xff111111);

  return baseTheme.copyWith(
    backgroundColor: _bgColor,
    scaffoldBackgroundColor: _bgColor,
    accentColor: Colors.grey,
    textTheme: _buidlDarkTextTheme(baseTheme.textTheme),
    primaryTextTheme: _buidlDarkTextTheme(baseTheme.primaryTextTheme),
    accentTextTheme: _buidlDarkTextTheme(baseTheme.accentTextTheme),
  );
}

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
