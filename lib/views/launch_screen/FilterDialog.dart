import 'package:flutter/material.dart';
import 'package:popular_movies/logic/PopularMoviesBloc.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({this.currentFilter, this.onTap});

  final MoviesFilter currentFilter;
  final Function(MoviesFilter) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _listTile("Popular movies", MoviesFilter.popular),
        _listTile("Top rated", MoviesFilter.topRated),
        _listTile("Favorites", MoviesFilter.favorites),
      ],
    );
  }

  Widget _listTile(String title, MoviesFilter filter) {
    return Center(
      child: ListTile(
        onTap: () => onTap(filter),
        title: Text(title),
        leading: Icon(
          Icons.check,
          color: currentFilter == filter
              ? Colors.yellowAccent
              : Colors.transparent,
        ),
      ),
    );
  }
}
