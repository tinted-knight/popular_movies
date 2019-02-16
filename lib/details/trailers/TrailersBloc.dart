import 'package:popular_movies/base/BaseBloc.dart';
import 'package:popular_movies/base/repo/repo.dart';
import 'package:popular_movies/model/TrailerModel.dart';

class TrailersBloc extends BaseBloc<TrailersBlocState> {
  TrailersBloc(Repository repository) : super(repository);

  void loadTrailers(String movieId) {
    streamController.sink.add(TrailersBlocState._loading());
    repository.fetchTrailers(movieId).then((trailerModel) {
      if (trailerModel != null && trailerModel.trailers.length > 0) {
        streamController.sink
            .add(TrailersBlocState._values(trailerModel.trailers));
      }
    });
  }
}

class TrailersBlocState {
  TrailersBlocState();

  factory TrailersBlocState._loading() = TrailersStateLoading;

  factory TrailersBlocState._values(List<TrailerItem> values) =
      TrailersStateValues;
}

class TrailersStateLoading extends TrailersBlocState {}

class TrailersStateValues extends TrailersBlocState {
  TrailersStateValues(this.trailers);

  final List<TrailerItem> trailers;
}
