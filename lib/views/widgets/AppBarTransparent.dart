import 'package:flutter/material.dart';

class AppBarTransparent extends StatelessWidget {
  AppBarTransparent.withTitle(this.title);

  AppBarTransparent() : this.withTitle("");

  final String title;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        elevation: 0.0,
        title: Text(title),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
