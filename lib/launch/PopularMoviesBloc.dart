import 'package:popular_movies/base/BaseBloc.dart';
import 'package:popular_movies/base/repo/repo.dart';
import 'package:popular_movies/model/tmdb.dart';

abstract class IMovies extends IBlock<MoviesBlocState> {
  void loadPopularMovies();
}

class MoviesBloc extends BaseBloc<MoviesBlocState> implements IMovies {
  MoviesBloc(Repository repository) : super(repository);

  @override
  void loadPopularMovies() {
    streamController.sink.add(MoviesBlocState._loading());
    repository.fetchPopularMovies().then((response) {
      if (response != null) {
        streamController.sink.add(MoviesBlocState._values(response));
      }
    });
  }
}

class MoviesBlocState {
  MoviesBlocState();

  factory MoviesBlocState._loading() = MoviesStateLoading;

  factory MoviesBlocState._values(Tmdb values) = MoviesStateData;
}

class MoviesStateLoading extends MoviesBlocState {}

class MoviesStateData extends MoviesBlocState {
  MoviesStateData(this.value);

  final Tmdb value;
}