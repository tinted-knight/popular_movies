import 'package:flutter/material.dart';
import 'package:popular_movies/launch/MovieItemWidget.dart';
import 'package:popular_movies/model/tmdb.dart';
import 'package:popular_movies/styles/MovieGridStyle.dart';

class SimpleMovieList extends StatelessWidget {
  const SimpleMovieList({this.onTap, this.items});

  final Function(Result) onTap;
  final List<Result> items;

  @override
  Widget build(BuildContext context) {
    return _buildGrid(items);
  }

  Widget _buildGrid(List<Result> values) {
    return new GridView.builder(
      gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
        crossAxisSpacing: kItemsSpacing,
        mainAxisSpacing: kItemsSpacing,
        maxCrossAxisExtent: kTilesExtent,
        childAspectRatio: kGridItemAspectRatio,
      ),
      itemCount: values.length,
      itemBuilder: (_, int position) => _gridItemBuilder(values)[position],
    );
  }

  List<Widget> _gridItemBuilder(List<Result> values) {
    List<Widget> list = <Widget>[];
    values.forEach((item) => list.add(
          GestureDetector(
              child: MovieItemWidget(
                posterPath: item.posterPath,
                title: item.title,
                id: item.id,
              ),
              onTap: () => onTap(item)),
        ));
    return list;
  }
}
