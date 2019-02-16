import 'package:flutter/material.dart';
import 'package:popular_movies/launch/MovieList.dart';
import 'package:popular_movies/styles/Theme.dart';

var urlBase = "http://api.themoviedb.org/3/";
var urlPopular = "movie/popular?";

String text = "loading";

void main() => runApp(Home());

var myTheme = darkTheme;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: myTheme,
      home: MovieList(title: 'Flutter Demo (Tmdb Api)'),
    );
  }
}
