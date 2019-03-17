import 'package:flutter/material.dart';
import 'package:popular_movies/views/details_screen/reviews/AuthorLabel.dart';
import 'package:popular_movies/views/styles/DetailsScreen.dart';

class FullReviewDialog extends StatelessWidget {
  const FullReviewDialog({this.author, this.content});

  final String author;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: kReviewBgColor,
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AuthorLabel(author: author),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(content,
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(height: 1.1)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
