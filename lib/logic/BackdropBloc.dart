import 'package:popular_movies/base/logic/BaseBloc.dart';
import 'package:popular_movies/base/repo/IRepository.dart';
import 'package:popular_movies/model/BackdropModel.dart';

class BackdropBloc extends BaseBloc<BackdropBlocState> {
  BackdropBloc(IRepository repository) : super(repository);

  void loadBackdrops(String movieId) {
    streamController.sink.add(BackdropBlocState._loading());
    repository.fetchBackdrops(movieId).then((backdropData) {
      if (backdropData != null) {
        streamController.sink.add(BackdropBlocState._values(backdropData));
      }
    });
  }
}

class BackdropBlocState {
  BackdropBlocState();

  factory BackdropBlocState._loading() = BackdropStateLoading;

  factory BackdropBlocState._values(BackdropModel backdropItems) =
      BackdropStateValues;
}

class BackdropStateLoading extends BackdropBlocState {}

class BackdropStateValues extends BackdropBlocState {
  BackdropStateValues(this.values);

  final BackdropModel values;
}
