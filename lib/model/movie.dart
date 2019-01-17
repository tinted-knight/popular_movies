import 'package:popular_movies/model/tmdb.dart';

class Movie {
  final String title;
  final String posterPath;
  final String releaseDate;
  final String overview;
  final num voteAverage;
  final num id;

  Movie({this.id,
      this.voteAverage,
      this.releaseDate,
      this.overview,
      this.title,
      this.posterPath});

  Movie.fromResult(Result r)
      : title = r.title,
        id = r.id,
        posterPath = r.posterPath,
        releaseDate = r.releaseDate,
        overview = r.overview,
        voteAverage = r.voteAverage;
}
