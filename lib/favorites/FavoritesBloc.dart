import 'package:popular_movies/base/BaseBloc.dart';
import 'package:popular_movies/base/repo/repo.dart';
import 'package:popular_movies/model/tmdb.dart';

class FavoritesBloc extends BaseBloc<FavoritesStates> {
  FavoritesBloc(Repository repository) : super(repository);

  loadWithSql() {
    streamController.sink.add(FavoritesStates._loading());
    repository.fetchFavoritesDb().then((list) {
      streamController.sink.add(FavoritesStates._values(list));
    });
  }

  loadWithSharedPrefs() {
    streamController.sink.add(FavoritesStates._loading());
    repository.fetchFavoritesSharedPrefs().then((list) {
      streamController.sink.add(FavoritesStates._values(list));
    });
  }
}

class FavoritesStates {
  FavoritesStates();

  factory FavoritesStates._loading() = FavoritesStateLoading;

  factory FavoritesStates._values(List<Result> values) = FavoritesStateList;
}

class FavoritesStateLoading extends FavoritesStates {}

class FavoritesStateList extends FavoritesStates {
  FavoritesStateList(this.values);

  final List<Result> values;
}
