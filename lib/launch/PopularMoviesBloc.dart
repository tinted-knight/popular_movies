import 'package:popular_movies/base/BaseBloc.dart';
import 'package:popular_movies/base/repo/repo.dart';
import 'package:popular_movies/model/tmdb.dart';

class MoviesBloc extends BaseBloc<MoviesBlocState> {
  MoviesBloc(
      {Repository repository, MoviesFilter filter = MoviesFilter.popular})
      : _filter = filter,
        super(repository);

  MoviesFilter _filter;

  get filter => _filter;

  set filter(MoviesFilter value) {
    if (value == null || value == _filter) return;
    _filter = value;
    loadMovies();
  }

  void loadMovies() {
    print('loadMovies, filter = $_filter');
    switch (_filter) {
      case MoviesFilter.popular:
        _loadPopularMovies();
        break;
      case MoviesFilter.topRated:
        _loadTopRatedMovies();
        break;
    }
  }

  void _loadPopularMovies() {
    print('loadPopular');
    streamController.sink.add(MoviesBlocState._loading());
    repository.fetchPopularMovies().then((response) {
      if (response != null) {
        print('loadPopularMovies, from network');
        streamController.sink.add(MoviesBlocState._values(response));
      }
    });
  }

  void _loadTopRatedMovies() {
    print('loadTopRated');
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
