import 'package:popular_movies/model/ReviewModel.dart';
import 'package:popular_movies/model/TrailerModel.dart';
import 'package:http/http.dart' show Client;
import 'package:popular_movies/api_key.dart';
import 'dart:convert';

import 'package:popular_movies/model/tmdb.dart';

class Repository {

  final _urlBase = "http://api.themoviedb.org/3/";
  final _urlPopular = "movie/popular?";
  final _urlTopRated = "movie/top_rated?";

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

  Future<TrailerModel> fetchTrailers(String movieId) async {
    var client = Client();
    final response = await client.get(
        "https://api.themoviedb.org/3/movie/$movieId/videos?$apiKey");
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

}