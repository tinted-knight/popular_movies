import 'package:popular_movies/base/BaseBloc.dart';
import 'package:popular_movies/base/repo/repo.dart';
import 'package:popular_movies/model/tmdb.dart';

class FavoriteLogic extends BaseBloc<FavoriteState> {
  FavoriteLogic({Repository repository, this.movie}) : super(repository) {
    streamController.sink.add(FavoriteState.inProgress);
    _checkIsFavorite();
  }

  final Result movie;

  String get movieId => movie.id.toString();

  bool _isFavorite;

  set _favorite(bool value) {
    _isFavorite = value;
    if (_isFavorite)
      streamController.sink.add(FavoriteState.marked);
    else
      streamController.sink.add(FavoriteState.notMarked);
  }

  void markFavorite() async {
    streamController.sink.add(FavoriteState.inProgress);
    bool result = await repository.switchFavoriteMark(movie, _isFavorite);
    if (result)
      streamController.sink.add(FavoriteState.marked);
    else
      streamController.sink.add(FavoriteState.notMarked);
  }

  void _checkIsFavorite() async {
    _favorite = await repository.checkIsFavorite(movieId);
  }
}

enum FavoriteState { marked, notMarked, inProgress }
