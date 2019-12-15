import 'package:flutter/material.dart';
import 'package:popular_movies/base/logic/BaseBloc.dart';
import 'package:popular_movies/views/details_screen/screen_details.dart';
import 'package:popular_movies/logic/FavoriteListBloc.dart';
import 'package:popular_movies/views/widgets/SimpleMovieList.dart';
import 'package:popular_movies/model/tmdb.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FavoriteListBloc bloc = BlocProvider.of<FavoriteListBloc>(context);
    bloc.load();

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites in SQLite DB"),
        centerTitle: true,
      ),
      body: StreamBuilder<FavoriteListStates>(
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
          return null;
        },
      ),
    );
  }
}

_movieItemOnTap(Result item, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => DetailsScreen(movie: item)),
  );
}
