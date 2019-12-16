import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:popular_movies/base/repo/IRepository.dart';
import 'package:popular_movies/model/tmdb.dart';
import 'package:sqflite/sqflite.dart';

const _table = "Favorites";

class SQLiteStorage implements ILocalStorage<Result> {
  @override
  Future<bool> checkIsFavorite(String movieId) async {
    final db = await DBProvider.db.database;
    // Achtung: fake delay
    var mark = await Future<List<Map<String, dynamic>>>.delayed(
      Duration(milliseconds: 500),
      () => db.query(_table, where: "id = ?", whereArgs: [movieId]),
    );
    if (mark != null && mark.length > 0) {
      return true;
    }
    return false;
  }

  @override
  Future<List<Result>> getFavoritesList() async {
    final db = await DBProvider.db.database;
    var list = await db.query(_table);
    return list.map((item) => Result.fromJson(item)).toList();
  }

  @override
  Future<bool> switchFavoriteMark(Result movie, bool currentMark) async {
    final db = await DBProvider.db.database;
    var search = await db.query(_table, where: "id = ?", whereArgs: [movie.id]);
    if (search != null && search.length > 0) {
      return await _removeMark(db, movie);
    } else {
      return await _setMark(db, movie);
    }
  }

  Future<bool> _removeMark(Database db, Result movie) async {
    var res = await db.delete(_table, where: "id = ?", whereArgs: [movie.id]);
    return res > 0 ? true : false;
  }

  Future<bool> _setMark(Database db, Result movie) async {
    var res = await db.insert(_table, movie.toJson());
    return res >= 0 ? true : false;
  }
}

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentDir = await getApplicationDocumentsDirectory();
    String path = join(documentDir.path, "favorites_db.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE  $_table ("
            "id INTEGER PRIMARY KEY, "
            "title TEXT, "
            "vote_average INTEGER, "
            "poster_path TEXT, "
            "backdrop_path TEXT, "
            "release_date TEXT, "
            "overview TEXT)");
      },
    );
  }
}
