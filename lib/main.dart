import 'package:flutter/material.dart';
import 'package:popular_movies/base/logic/BaseBloc.dart';
import 'package:popular_movies/logic/FavoriteListBloc.dart';
import 'package:popular_movies/logic/PopularMoviesBloc.dart';
import 'package:popular_movies/logic/repository/Repository.dart';
import 'package:popular_movies/logic/repository/SQLiteStorage.dart';
import 'package:popular_movies/views/favorites_screen/screen_favorites.dart';
import 'package:popular_movies/views/launch_screen/screen_movieList.dart';
import 'package:popular_movies/views/styles/Theme.dart';

var urlBase = "http://api.themoviedb.org/3/";
var urlPopular = "movie/popular?";

String text = "loading";

void main() => runApp(Home());

var myTheme = darkTheme;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Repository repository = Repository(SQLiteStorage());

    return MaterialApp(
      title: 'Flutter Demo',
      theme: myTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider(
              bloc: MoviesBloc(repository: repository),
              child: MovieListScreen(title: 'Flutter Demo (Tmdb Api)'),
            ),
        '/favorites': (context) => BlocProvider(
              bloc: FavoriteListBloc(repository),
              child: FavoritesScreen(),
            ),
      },
    );
  }
}
