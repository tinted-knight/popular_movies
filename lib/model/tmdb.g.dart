// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tmdb _$TmdbFromJson(Map<String, dynamic> json) {
  return new Tmdb(
      page: json['page'] as int,
      results: (json['results'] as List)
          ?.map((e) =>
              e == null ? null : new Result.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

abstract class _$TmdbSerializerMixin {
  int get page;
  List<Result> get results;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'page': page, 'results': results};
}

Result _$ResultFromJson(Map<String, dynamic> json) {
  return new Result(
      json['title'] as String,
      json['poster_path'] as String,
      json['release_date'] as String,
      json['overview'] as String,
      json['vote_average'] as num,
      json['id'] as num);
}

abstract class _$ResultSerializerMixin {
  num get id;
  String get title;
  num get voteAverage;
  String get posterPath;
  String get releaseDate;
  String get overview;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'vote_average': voteAverage,
        'poster_path': posterPath,
        'release_date': releaseDate,
        'overview': overview
      };
}
