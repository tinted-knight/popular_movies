import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:popular_movies/api_key.dart';
import 'package:popular_movies/base/BaseScafold.dart';
import 'package:popular_movies/details/details.dart';
import 'package:popular_movies/item.dart';
import 'package:popular_movies/tmdb.dart';

var urlBase = "http://api.themoviedb.org/3/";
var urlPopular = "movie/popular?";

String text = "loading";

void main() => runApp(new PopularMovies());

class PopularMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: new MyHomePage(title: 'Flutter Demo (Tmdb Api)'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> _data = <Widget>[];

  _MyHomePageState() {
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: bgColor,
      appBar: new AppBar(
        title: new Text(widget.title),
        centerTitle: true,
        backgroundColor: bgColor,
      ),
      body: _buildGrid(),
    );
  }

  Widget _buildGrid() {
    return new GridView.builder(
      gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        maxCrossAxisExtent: 200.0,
        childAspectRatio: 0.67,
      ),
      itemCount: _getItemCount(),
      itemBuilder: (_, int position) {
        if(_data.length == 0) return new CircularProgressIndicator();
        return _data[position];
      },
    );
  }

  void _loadData() {
    http.read(getPopularUrl()).then((response) {
      Map data = json.decode(response.toString());
      Tmdb tmdb = new Tmdb.fromJson(data);
      setState(() {
        for (Result movie in tmdb.results) {
          _data.add(new GestureDetector(
              child: new ItemWidget(
                  posterPath: movie.posterPath,
                  title: movie.title,
                  id: movie.id),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (_) => new Details(movie: movie)));
              }));
        }
      });
    });
  }

  String getPopularUrl() {
    return urlBase + urlPopular + apiKey;
  }

  int _getItemCount() {
    if (_data != null && _data.length != 0) return _data.length;
    return 0;
  }
}
