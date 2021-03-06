import 'package:json_annotation/json_annotation.dart';

part 'package:popular_movies/model/tmdb.g.dart';

@JsonSerializable()
class Tmdb extends Object with _$TmdbSerializerMixin {
  Tmdb({this.page, this.results});

  final int page;
  List<Result> results;

  factory Tmdb.fromJson(Map<String, dynamic> json) => _$TmdbFromJson(json);
}

@JsonSerializable()
class Result extends Object with _$ResultSerializerMixin {
  final num id;

  final String title;

  @JsonKey(name: "vote_average")
  final num voteAverage;

  @JsonKey(name: "poster_path")
  final String posterPath;

  @JsonKey(name: "backdrop_path")
  final String backdropPath;

  @JsonKey(name: "release_date")
  final String releaseDate;

  final String overview;

  Result(this.title, this.posterPath, this.releaseDate, this.overview,
      this.voteAverage, this.id, this.backdropPath);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}
