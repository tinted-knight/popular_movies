import 'package:popular_movies/tmdb.dart';

class Movie {
  final String title;
  final String posterPath;
  final String releaseDate;
  final String overview;
  final num voteAverage;

  Movie(
      {this.voteAverage,
      this.releaseDate,
      this.overview,
      this.title,
      this.posterPath});

  Movie.fromResult(Result r)
      : title = r.title,
        posterPath = r.posterPath,
        releaseDate = r.releaseDate,
        overview = r.overview,
        voteAverage = r.voteAverage;
}
