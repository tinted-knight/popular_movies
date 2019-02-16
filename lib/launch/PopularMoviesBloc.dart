import 'package:popular_movies/base/BaseBloc.dart';
import 'package:popular_movies/base/repo/repo.dart';
import 'package:popular_movies/model/tmdb.dart';

abstract class IMovies extends IBloc<MoviesBlocState> {
  void loadPopularMovies();

  void loadTopRatedMovies();
}

class MoviesBloc extends BaseBloc<MoviesBlocState> implements IMovies {
  MoviesBloc(Repository repository) : super(repository);

  @override
  void loadPopularMovies() {
    streamController.sink.add(MoviesBlocState._loading());
    repository.fetchPopularMovies().then((response) {
      if (response != null) {
        print('loadPopularMovies, from network');
        streamController.sink.add(MoviesBlocState._values(response));
      }
    });
  }

  @override
  void loadTopRatedMovies() {
    streamController.sink.add(MoviesBlocState._loading());
    repository.fetchTopRatedMovies().then((response) {
      if (response != null) {
        print('loadTopRatedMovies, from network');
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

enum MoviesFilter { popular, topRated }
