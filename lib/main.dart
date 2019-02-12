import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:popular_movies/styles/Theme.dart';
import 'package:popular_movies/base/repo/repo.dart';
import 'package:popular_movies/details/details.dart';
import 'package:popular_movies/launch/PopularMoviesBloc.dart';
import 'package:popular_movies/launch/item.dart';
import 'package:popular_movies/model/tmdb.dart';
import 'package:popular_movies/styles/MovieGridStyle.dart';

var urlBase = "http://api.themoviedb.org/3/";
var urlPopular = "movie/popular?";

String text = "loading";

void main() => runApp(PopularMovies());

var myTheme = darkTheme;

class PopularMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: myTheme,
      home: MovieList(title: 'Flutter Demo (Tmdb Api)'),
    );
  }
}

class MovieList extends StatefulWidget {
  MovieList({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MovieListState createState() => new _MovieListState();
}

class _MovieListState extends State<MovieList> {
  IMovies _moviesBloc;

  @override
  void initState() {
    _moviesBloc = MoviesBloc(Repository());
    _moviesBloc.loadPopularMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        centerTitle: true,
      ),
      body: StreamBuilder<MoviesBlocState>(
        stream: _moviesBloc.states,
        initialData: MoviesStateLoading(),
        builder: (_, snapshot) {
          if (snapshot.data is MoviesStateLoading) {
            print("loading");
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data is MoviesStateData) {
            print("done");
            MoviesStateData data = snapshot.data;
            return _buildGrid(data.value.results);
          }
        },
      ),
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
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            new DetailsSliveredAppBar(movie: item)));
              }),
        ));
    return list;
  }

  @override
  void dispose() {
    _moviesBloc.dispose();
    super.dispose();
  }
}
