import 'package:flutter/material.dart';
import 'package:popular_movies/base/BaseBloc.dart';
import 'package:popular_movies/details/DetailsScreen.dart';
import 'package:popular_movies/favorites/MovieList.dart';
import 'package:popular_movies/launch/FilterDialog.dart';
import 'package:popular_movies/launch/PopularMoviesBloc.dart';
import 'package:popular_movies/model/tmdb.dart';

class MovieList extends StatefulWidget {
  MovieList({this.title});

  final String title;

  @override
  _MovieListState createState() => new _MovieListState();
}

class _MovieListState extends State<MovieList> {
  MoviesBloc moviesBloc;

  @override
  void initState() {
    print('main initState');
    moviesBloc = BlocProvider.of<MoviesBloc>(context);
    moviesBloc.loadMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: StreamBuilder<MoviesBlocState>(
        stream: moviesBloc.states,
        initialData: MoviesStateLoading(),
        builder: (_, snapshot) {
          if (snapshot.data is MoviesStateLoading) {
            print("sb loading");
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data is MoviesStateData) {
            print("sb done");
            MoviesStateData data = snapshot.data;
            return SimpleMovieList(
              onTap: _movieItemTap,
              items: data.value.results,
            );
          }
          // favorite list from SharedPreferences
          if (snapshot.data is MoviesStateList) {
            MoviesStateList data = snapshot.data;
            return SimpleMovieList(
              onTap: _movieItemTap,
              items: data.values,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.yellowAccent,
        child: IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: () {
            _showFilterPopup();
          },
        ),
      ),
    );
  }

  void _movieItemTap(Result item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailsScreen(movie: item)),
    );
  }

  void _showFilterPopup() async {
    var filter = await showModalBottomSheet<MoviesFilter>(
        context: context,
        builder: (_) {
          return FilterDialog(
            currentFilter: moviesBloc.filter,
            onTap: (filter) {
              Navigator.of(context).pop(filter);
            },
          );
        });
    if (filter == MoviesFilter.favDB) {
      // show in new screen
      _gotoFavoritesScreen();
    } else if (filter == MoviesFilter.favSP) {
      _gotoFavoritesScreen();
    } else {
      // stay in current screen, just apply filter
      moviesBloc.filter = filter;
    }
  }

  _gotoFavoritesScreen() => Navigator.of(context).pushNamed('/favorites');

  @override
  void dispose() {
    print('main dispose');
    super.dispose();
    moviesBloc.dispose();
  }
}
