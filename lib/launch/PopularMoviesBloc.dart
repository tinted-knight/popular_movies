import 'package:popular_movies/base/BaseBloc.dart';
import 'package:popular_movies/base/repo/repo.dart';
import 'package:popular_movies/model/tmdb.dart';

class MoviesBloc extends BaseBloc<MoviesBlocState> {
  MoviesBloc({
    Repository repository,
    MoviesFilter filter = MoviesFilter.popular,
  })  : _filter = filter,
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
      case MoviesFilter.favSP:
        _loadFavorites();
        break;
    }
  }

  void _loadPopularMovies() {
    streamController.sink.add(MoviesBlocState._loading());
    repository.fetchPopularMovies().then((response) {
      if (response != null) {
        streamController.sink.add(MoviesBlocState._values(response));
      }
    });
  }

  void _loadTopRatedMovies() {
    streamController.sink.add(MoviesBlocState._loading());
    repository.fetchTopRatedMovies().then((response) {
      if (response != null) {
        streamController.sink.add(MoviesBlocState._values(response));
      }
    });
  }

  void _loadFavorites() {
    print('favoritesFromSharedPrefs');
    repository.fetchFavorites().then((list) {
      if (list != null) {
        streamController.sink.add(MoviesBlocState._valuesList(list));
      }
    });
  }
}

class MoviesBlocState {
  MoviesBlocState();

  factory MoviesBlocState._loading() = MoviesStateLoading;

  factory MoviesBlocState._values(Tmdb values) = MoviesStateData;

  factory MoviesBlocState._valuesList(List<Result> values) = MoviesStateList;
}

class MoviesStateLoading extends MoviesBlocState {}

class MoviesStateData extends MoviesBlocState {
  MoviesStateData(this.value);

  final Tmdb value;
}

class MoviesStateList extends MoviesBlocState {
  MoviesStateList(this.values);

  final List<Result> values;
}

enum MoviesFilter { popular, topRated, favSP }
