import 'package:popular_movies/base/logic/BaseBloc.dart';
import 'package:popular_movies/logic/repository/Repository.dart';
import 'package:popular_movies/model/tmdb.dart';

class DetailsMarkFavoriteBloc extends BaseBloc<FavoriteState> {
  DetailsMarkFavoriteBloc({Repository repository, this.movie})
      : super(repository) {
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

  void switchMark() async {
    streamController.sink.add(FavoriteState.inProgress);
    bool result = await repository.switchFavoriteMark(movie, _isFavorite);
    if (result)
      _favorite = !_isFavorite;
    else
      print('Something gone wrong while switching favorite mark');
  }

  void _checkIsFavorite() async {
    _favorite = await repository.checkIsFavorite(movieId);
  }
}

enum FavoriteState { marked, notMarked, inProgress }
