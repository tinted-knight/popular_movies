import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:popular_movies/api_key.dart';
import 'package:popular_movies/base/repo/LocalSpStorage.dart';
import 'package:popular_movies/model/ReviewModel.dart';
import 'package:popular_movies/model/TrailerModel.dart';
import 'package:popular_movies/model/tmdb.dart';

abstract class LocalStorage {
  Future<bool> switchFavoriteMark(Result movie, bool currentMark);

  Future<bool> checkIsFavorite(String movieId);

  Future<List<Result>> getFavoritesList();
}

class Repository {
  static const String favKey = "favs";

  final _urlBase = "http://api.themoviedb.org/3/";
  final _urlPopular = "movie/popular?";
  final _urlTopRated = "movie/top_rated?";

  final LocalStorage _local = LocalSpStorage();

  Future<Tmdb> fetchPopularMovies() async {
    var client = Client();
    final response = await client.get(_urlBase + _urlPopular + apiKey);
    if (response.statusCode == 200) {
      print("fetchPopMovies, status code 200");
      return Tmdb.fromJson(json.decode(response.body));
    } else {
      print("fetchPopularMovies, error");
      return null;
    }
  }

  Future<Tmdb> fetchTopRatedMovies() async {
    var client = Client();
    final response = await client.get(_urlBase + _urlTopRated + apiKey);
    if (response.statusCode == 200) {
      print("fetchTopRated, status code 200");
      return Tmdb.fromJson(json.decode(response.body));
    } else {
      print("fetchTopRated, error");
      return null;
    }
  }

  Future<List<Result>> fetchFavorites() {
    return _local.getFavoritesList();
  }
  
  Future<TrailerModel> fetchTrailers(String movieId) async {
    var client = Client();
    final response = await client
        .get("https://api.themoviedb.org/3/movie/$movieId/videos?$apiKey");
    if (response.statusCode == 200) {
      print("fetchTrailers, statusCode 200");
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      print("fetchTrailers, error");
      return null;
    }
  }

  Future<ReviewModel> fetchReviews(String movieId) async {
    var client = Client();
    final response = await client
        .get("https://api.themoviedb.org/3/movie/$movieId/reviews?$apiKey");
    if (response.statusCode == 200) {
      print("fetchReviews, status code 200");
      return ReviewModel.fromJson(json.decode(response.body));
    } else
      print("fetchReviews, error");
    return null;
  }

  Future<bool> switchFavoriteMark(Result movie, bool currentMark) {
    return _local.switchFavoriteMark(movie, currentMark);
  }

  Future<bool> checkIsFavorite(String movieId) {
    return _local.checkIsFavorite(movieId);
  }
}