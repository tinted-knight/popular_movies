import 'package:flutter/material.dart';

class AppBarTransparent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
