import 'package:flutter/material.dart';
import 'package:popular_movies/base/BaseBloc.dart';
import 'package:popular_movies/details/DetailsScreen.dart';
import 'package:popular_movies/favorites/FavoritesBloc.dart';
import 'package:popular_movies/favorites/MovieList.dart';
import 'package:popular_movies/launch/PopularMoviesBloc.dart';
import 'package:popular_movies/model/tmdb.dart';

class Favorites extends StatelessWidget {
  const Favorites({@required this.filter});

  final MoviesFilter filter;

  @override
  Widget build(BuildContext context) {
    final FavoritesBloc bloc = BlocProvider.of<FavoritesBloc>(context);
    filter == MoviesFilter.favDB
        ? bloc.loadWithSql()
        : bloc.loadWithSharedPrefs();

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites in SQLite DB"),
        centerTitle: true,
      ),
      body: StreamBuilder<FavoritesStates>(
        initialData: FavoritesStateLoading(),
        stream: bloc.states,
        builder: (_, snapshot) {
          if (snapshot.data is FavoritesStateLoading)
            return CircularProgressIndicator();
          if (snapshot.data is FavoritesStateList) {
            FavoritesStateList state = snapshot.data;
            return SimpleMovieList(
              onTap: (item) => _movieItemOnTap(item, context),
              items: state.values,
            );
          }
        },
      ),
    );
  }

  _movieItemOnTap(Result item, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailsScreen(movie: item)),
    );
  }
}
