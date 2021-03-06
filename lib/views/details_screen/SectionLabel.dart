import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  final String text;

  const SectionLabel(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
      margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      padding: const EdgeInsets.fromLTRB(32.0, 4.0, 32.0, 4.0),
      child: new Text(
        text,
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
