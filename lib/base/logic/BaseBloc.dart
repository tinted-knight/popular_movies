import 'dart:async';

import 'package:flutter/material.dart';
import 'package:popular_movies/base/repo/IRepository.dart';
import 'package:popular_movies/logic/repository/Repository.dart';

abstract class BaseBloc<States> {
  BaseBloc(this._repository);

  final IRepository _repository;

  final streamController = StreamController<States>();

  Stream<States> get states => streamController.stream;

  // Achtung очень криво
  IRepository get repository => _repository;

  void dispose() {
    streamController.close();
  }
}

//TODO https://github.com/boeledi/Streams-Block-Reactive-Programming-in-Flutter/blob/master/lib/blocs/bloc_provider.dart
class BlocProvider<T extends BaseBloc> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  final T bloc;
  final Widget child;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BaseBloc>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<BlocProvider<BaseBloc>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
