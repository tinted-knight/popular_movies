import 'dart:convert';

import 'package:popular_movies/base/repo/IRepository.dart';
import 'package:popular_movies/logic/repository/Repository.dart';
import 'package:popular_movies/model/tmdb.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsStorage implements ILocalStorage<Result> {
  SharedPrefsStorage() {
    _getList();
  }

  final Future<SharedPreferences> _getPrefs = SharedPreferences.getInstance();

  String get _favKey => Repository.favKey;
  List<String> _list;

  @override
  Future<bool> switchFavoriteMark(Result movie, bool currentMark) async {
    bool checked = currentMark;
    String movieId = movie.id.toString();

    // Achtung fake delay to force show loading indicator
    SharedPreferences sp = await Future<SharedPreferences>.delayed(
      Duration(seconds: 1),
      () => _getPrefs,
    );

    if (!checked) {
      checked = await sp.setString(movieId, json.encode(movie.toJson()));
      _list.add(movieId);
    } else {
      checked = !(await sp.remove(movieId));
      _list.remove(movieId);
    }

    await _updateList(sp);

    return checked;
  }

  @override
  Future<bool> checkIsFavorite(String movieId) async {
    SharedPreferences sp = await _getPrefs;
    try {
      var s = sp.getString(movieId);
      if (s != null)
        return true;
      else
        return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Result>> getFavoritesList() async {
    SharedPreferences sp = await _getPrefs;
    List<String> movieIds = sp.getStringList(_favKey);
    List<Result> res = <Result>[];
    movieIds.forEach((id) {
      Result r = Result.fromJson(json.decode(sp.getString(id)));
      res.add(r);
    });
    return res;
  }

  Future<bool> _updateList(SharedPreferences sp) {
    return sp.setStringList(_favKey, _list);
  }

  // TODO: Everything with this list is super bad and made only for demo purpose
  //  it will quickly become slower as the list grows
  void _getList() async {
    SharedPreferences sp = await _getPrefs;
    _list = sp.getStringList(_favKey);
    if (_list == null) {
      await sp.setStringList(_favKey, <String>[]);
      _list = sp.getStringList(_favKey);
    }
  }
}
