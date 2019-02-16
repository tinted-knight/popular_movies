import 'package:flutter/material.dart';
import 'package:popular_movies/base/repo/repo.dart';
import 'package:popular_movies/details/DetailsScreen.dart';
import 'package:popular_movies/launch/FilterDialog.dart';
import 'package:popular_movies/launch/PopularMoviesBloc.dart';
import 'package:popular_movies/launch/PopularStreamWidget.dart';

class MovieList extends StatefulWidget {
  MovieList({this.title});

  final String title;

  @override
  _MovieListState createState() {
    print('main createState');
    return new _MovieListState();
  }
}

class _MovieListState extends State<MovieList> {
  IMovies _popularBloc;
  MoviesFilter _filter;

  @override
  void initState() {
    print('main initState');
    _popularBloc = MoviesBloc(Repository());
    _popularBloc.loadPopularMovies();
    _filter = MoviesFilter.popular;
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
      body: PopularStreamWidget(
        states: _popularBloc.states,
        itemTap: (item) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => new DetailsScreen(movie: item)));
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

  void _showFilterPopup() async {
    _handleFilterOption(
      await showModalBottomSheet<MoviesFilter>(
          context: context,
          builder: (_) {
            return FilterDialog(
              currentFilter: _filter,
              onTap: (filter) {
                Navigator.of(context).pop(filter);
              },
            );
          }),
    );
  }

  void _handleFilterOption(MoviesFilter filter) {
    print('_filter is $_filter, filter is $filter');
    if (_filter == filter || filter == null) return;
    _filter = filter;
    switch (_filter) {
      case MoviesFilter.popular:
        _popularBloc.loadPopularMovies();
        break;
      case MoviesFilter.topRated:
        _popularBloc.loadTopRatedMovies();
        break;
    }
  }

  @override
  void dispose() {
    print('main dispose');
    super.dispose();
    _popularBloc.dispose();
  }
}
