import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:popular_movies/api_key.dart';
import 'package:popular_movies/base/repo/IRepository.dart';
import 'package:popular_movies/model/BackdropModel.dart';
import 'package:popular_movies/model/ReviewModel.dart';
import 'package:popular_movies/model/TrailerModel.dart';
import 'package:popular_movies/model/tmdb.dart';

class Repository
    implements IRepository<Result, TrailerItem, ReviewItem, PosterItem> {
  static const String favKey = "favs";

  final _urlBase = "http://api.themoviedb.org/3/";
  final _urlPopular = "movie/popular?";
  final _urlTopRated = "movie/top_rated?";

  final ILocalStorage storage;

  Repository(this.storage);

  @override
  Future<List<Result>> fetchPopularMovies() async {
    var client = Client();
    final response = await client.get(_urlBase + _urlPopular + apiKey);
    if (response.statusCode == 200) {
      print("fetchPopMovies, status code 200");
      return Tmdb.fromJson(json.decode(response.body)).results;
    } else {
      print("fetchPopularMovies, error");
      return null;
    }
  }

  @override
  Future<List<Result>> fetchTopRatedMovies() async {
    var client = Client();
    final response = await client.get(_urlBase + _urlTopRated + apiKey);
    if (response.statusCode == 200) {
      print("fetchTopRated, status code 200");
      return Tmdb.fromJson(json.decode(response.body)).results;
    } else {
      print("fetchTopRated, error");
      return null;
    }
  }

  @override
  Future<List<Result>> fetchFavorites() {
    return storage.getFavoritesList();
  }

  @override
  Future<List<TrailerItem>> fetchTrailers(String movieId) async {
    var client = Client();
    final response = await client
        .get("https://api.themoviedb.org/3/movie/$movieId/videos?$apiKey");
    if (response.statusCode == 200) {
      print("fetchTrailers, statusCode 200");
      return TrailerModel.fromJson(json.decode(response.body)).trailers;
    } else {
      print("fetchTrailers, error");
      return null;
    }
  }

  @override
  Future<List<ReviewItem>> fetchReviews(String movieId) async {
    var client = Client();
    final response = await client
        .get("https://api.themoviedb.org/3/movie/$movieId/reviews?$apiKey");
    if (response.statusCode == 200) {
      print("fetchReviews, status code 200");
      return ReviewModel.fromJson(json.decode(response.body)).results;
    } else {
      print("fetchReviews, error");
      return null;
    }
  }

  @override
  Future<List<PosterItem>> fetchBackdrops(String movieId) async {
    var client = Client();
    final response = await client
        .get("https://api.themoviedb.org/3/movie/$movieId/images?$apiKey");
    if (response.statusCode == 200) {
      print("fetchBackdrops, status code 200");
      return BackdropModel.fromJson(json.decode(response.body)).backdrops;
    } else {
      print("fetchBackdrops, error");
      return null;
    }
  }

  @override
  Future<bool> switchFavoriteMark(Result movie, bool currentMark) {
    return storage.switchFavoriteMark(movie, currentMark);
  }

  @override
  Future<bool> checkIsFavorite(String movieId) {
    return storage.checkIsFavorite(movieId);
  }
}
