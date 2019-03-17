import 'package:popular_movies/base/logic/BaseBloc.dart';
import 'package:popular_movies/logic/repository/Repository.dart';
import 'package:popular_movies/model/tmdb.dart';

class FavoriteListBloc extends BaseBloc<FavoriteListStates> {
  FavoriteListBloc(Repository repository) : super(repository);

  load() {
    streamController.sink.add(FavoriteListStates._loading());
    repository.fetchFavorites().then((list) {
      streamController.sink.add(FavoriteListStates._values(list));
    });
  }
}

class FavoriteListStates {
  FavoriteListStates();

  factory FavoriteListStates._loading() = FavoritesStateLoading;

  factory FavoriteListStates._values(List<Result> values) = FavoritesStateList;
}

class FavoritesStateLoading extends FavoriteListStates {}

class FavoritesStateList extends FavoriteListStates {
  FavoritesStateList(this.values);

  final List<Result> values;
}
