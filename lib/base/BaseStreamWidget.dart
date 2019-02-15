import 'package:flutter/material.dart';

abstract class BaseStreamWidget<States> extends StatelessWidget {
  const BaseStreamWidget(this.states);

  final Stream<States> states;
}
