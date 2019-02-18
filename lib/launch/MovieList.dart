import 'package:flutter/material.dart';
import 'package:popular_movies/base/BaseBloc.dart';
import 'package:popular_movies/base/repo/repo.dart';
import 'package:popular_movies/details/DetailsScreen.dart';
import 'package:popular_movies/launch/CommonMovieList.dart';
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
    print('main build');
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        centerTitle: true,
      ),
      body: BlocProvider(
        bloc: moviesBloc,
        child: CommonMovieList(
          onTap: _movieItemTap,
        ),
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
    moviesBloc.filter = await showModalBottomSheet<MoviesFilter>(
        context: context,
        builder: (_) {
          return FilterDialog(
            currentFilter: moviesBloc.filter,
            onTap: (filter) {
              Navigator.of(context).pop(filter);
            },
          );
        });
  }

  @override
  void dispose() {
    print('main dispose');
    super.dispose();
    moviesBloc.dispose();
  }
}
