import 'package:flutter/material.dart';
import 'package:popular_movies/base/BaseBloc.dart';
import 'package:popular_movies/base/repo/repo.dart';
import 'package:popular_movies/favorites/Favorites.dart';
import 'package:popular_movies/favorites/FavoritesBloc.dart';
import 'package:popular_movies/launch/MovieList.dart';
import 'package:popular_movies/launch/PopularMoviesBloc.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider(
              bloc: MoviesBloc(repository: Repository()),
              child: MovieList(title: 'Flutter Demo (Tmdb Api)'),
            ),
        '/favorites': (context) => BlocProvider(
              bloc: FavoritesBloc(Repository()),
              child: Favorites(filter: MoviesFilter.favDB),
            ),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/favorites') {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => BlocProvider(
                    bloc: FavoritesBloc(Repository()),
                    child: Favorites(filter: MoviesFilter.favDB),
                  ));
        }
      },
    );
  }
}
