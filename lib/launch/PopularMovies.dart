import 'package:flutter/material.dart';
import 'package:popular_movies/base/BaseBloc.dart';
import 'package:popular_movies/launch/PopularMoviesBloc.dart';
import 'package:popular_movies/launch/item.dart';
import 'package:popular_movies/model/tmdb.dart';
import 'package:popular_movies/styles/MovieGridStyle.dart';

class PopularList extends StatelessWidget {
  const PopularList({this.itemTap});

  final Function(Result) itemTap;

  @override
  Widget build(BuildContext context) {
    final MoviesBloc moviesBloc = BlocProvider.of<MoviesBloc>(context);

    return StreamBuilder<MoviesBlocState>(
      stream: moviesBloc.states,
      initialData: MoviesStateLoading(),
      builder: (_, snapshot) {
        if (snapshot.data is MoviesStateLoading) {
          print("sb loading");
          moviesBloc.loadPopularMovies();
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data is MoviesStateData) {
          print("sb done");
          MoviesStateData data = snapshot.data;
          return _buildGrid(data.value.results);
        }
      },
    );
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
      //TODO посмотреть пример, как-то че-то не так
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
          onTap: () => itemTap(item)),
    ));
    return list;
  }
}