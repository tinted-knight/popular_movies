import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:popular_movies/api_key.dart';
import 'package:popular_movies/model/ReviewModel.dart';
import 'package:http/http.dart' show Client;

class Reviews extends StatefulWidget {
  final num movieId;

  const Reviews({Key key, this.movieId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ReviewsState(movieId);
  }
}

class ReviewsState extends State<Reviews> {
  final List<Widget> _data = <Widget>[];

  ReviewsState(num movieId) {
    _fetchReviews(movieId.toString()).then((value) {
      if (value != null) {
        setState(() {
          for (ReviewItem review in value.results) {
            var length = 100;
            if (review.content.length < 100) length = review.content.length;
            _data.add(new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new AuthorLabel(author: review.author),
                new ReviewContent(review.content.substring(0, length)),
              ],
            ));
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: _data,
    );
  }

  Future<ReviewModel> _fetchReviews(String movieId) async {
    var client = Client();
    final response = await client
        .get("https://api.themoviedb.org/3/movie/$movieId/reviews?$apiKey");
    if (response.statusCode == 200) {
      print("200");
      return ReviewModel.fromJson(json.decode(response.body));
    } else
      return null;
  }
}

class AuthorLabel extends StatelessWidget {
  final String author;

  const AuthorLabel({Key key, this.author}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 16.0, 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(
            author,
            style: new TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          )
        ],
      ),
    );
  }
}

class ReviewContent extends StatelessWidget {
  final String value;

  ReviewContent(this.value);

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.centerLeft,
      decoration: new BoxDecoration(
          color: new Color(0xff222222),
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
      child: new Text(
        this.value,
        textAlign: TextAlign.start,
        style: new TextStyle(
          color: Colors.white70,
          fontSize: 16.0,
          height: 1.5,
        ),
      ),
    );
  }
}
