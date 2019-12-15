import 'package:popular_movies/base/logic/BaseBloc.dart';
import 'package:popular_movies/base/repo/IRepository.dart';
import 'package:popular_movies/model/BackdropModel.dart';

class BackdropBloc extends BaseBloc<BackdropBlocState> {
  BackdropBloc(IRepository repository) : super(repository);

  void loadBackdrops(String movieId) {
    streamController.sink.add(BackdropBlocState._loading());
    repository.fetchBackdrops(movieId).then((backdrops) {
      if (backdrops != null && backdrops.length > 0) {
        streamController.sink.add(BackdropBlocState._values(backdrops));
      }
    });
  }
}

class BackdropBlocState {
  BackdropBlocState();

  factory BackdropBlocState._loading() = BackdropStateLoading;

  factory BackdropBlocState._values(List<PosterItem> backdropItems) =
      BackdropStateValues;
}

class BackdropStateLoading extends BackdropBlocState {}

class BackdropStateValues extends BackdropBlocState {
  BackdropStateValues(this.backdropItems);

  final List<PosterItem> backdropItems;
}
