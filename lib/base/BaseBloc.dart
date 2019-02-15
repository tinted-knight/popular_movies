import 'dart:async';

import 'package:popular_movies/base/repo/repo.dart';

abstract class IBloc<T> {
  Stream<T> get states;

  void dispose();
}

abstract class BaseBloc<States> implements IBloc<States> {
  BaseBloc(this._repository);

  final Repository _repository;

  final _streamController = StreamController<States>();

  StreamController<States> get streamController => _streamController;

  @override
  Stream<States> get states => _streamController.stream;

  Repository get repository => _repository;

  @override
  void dispose() => _streamController.close();
}
