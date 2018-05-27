import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:popular_movies/tmdb.dart';

class Details extends StatelessWidget {
  final Result movie;

  const Details({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black45,
      appBar: new AppBar(
        title: new Text("Details"),
      ),
      body: new ListView(children: <Widget>[
        new Stack(
          children: <Widget>[
            new Center(
              child: new CachedNetworkImage(
                imageUrl: _getPosterUrl(),
                placeholder: new CircularProgressIndicator(),
                errorWidget: new Icon(Icons.error),
                height: 400.0,
              ),
            ),
            new Positioned(
              bottom: 0.0,
              right: 16.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: new BoxDecoration(color: Colors.red),
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: new Icon(
                            Icons.star,
                            color: Colors.white,
                          ),
                        ),
                        new Text(
                          movie.voteAverage.toString(),
                          style: voteTextStyle,
                        ),
                      ],
                    ),
                  ),
                  new Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: new BoxDecoration(color: Colors.white),
                      child: new Text(
                        movie.title,
                        style: titleTextStyle,
                      )),
                  new Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: new BoxDecoration(color: Colors.black45),
                    child: new Text(
                      "Released on: ${movie.releaseDate}",
                      style: releaseTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text(
            "Overview",
            style: overviewTextStyle,
          ),
        ),
        new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Text(
            movie.overview,
            style: overviewTextStyle,
          ),
        ),
      ]),
    );
  }

  String _getPosterUrl() {
    final String baseUrl = "http://image.tmdb.org/t/p/";
    final String qualifier = "w500";
    return baseUrl + qualifier + movie.posterPath;
  }
}

TextStyle titleTextStyle = new TextStyle(
  fontSize: 20.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

TextStyle overviewTextStyle = new TextStyle(
  color: Colors.white70,
  height: 1.5,
);

TextStyle releaseTextStyle = new TextStyle(
  color: Colors.white,
);

TextStyle voteTextStyle = new TextStyle(
  color: Colors.white,
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
);
