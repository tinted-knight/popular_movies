import 'package:flutter/material.dart';
import 'package:popular_movies/base/BaseStreamWidget.dart';
import 'package:popular_movies/details/SectionLabel.dart';
import 'package:popular_movies/details/reviews/AuthorLabel.dart';
import 'package:popular_movies/details/reviews/ReviewBloc.dart';
import 'package:popular_movies/details/reviews/ReviewContent.dart';
import 'package:popular_movies/model/ReviewModel.dart';
import 'package:popular_movies/strings.dart';

class ReviewsStreamWidget extends BaseStreamWidget<ReviewsBlocState> {
  ReviewsStreamWidget(Stream<ReviewsBlocState> states, {this.onTap})
      : super(states);

  final Function(String, String) onTap;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ReviewsBlocState>(
      stream: states,
      initialData: ReviewsStateLoading(),
      builder: (_, snapshot) {
        if (snapshot.data is ReviewsStateLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data is ReviewsStateData) {
          ReviewsStateData state = snapshot.data;
          return _buildReviews(state.reviewModel.results);
        }
      },
    );
  }

  Widget _buildReviews(List<ReviewItem> values) {
    if (values.length == 0) return SizedBox(height: 1.0);
    return Column(
      children: <Widget>[
        SectionLabel(StrRes.reviews),
        Column(children: _buildReviewList(values))
      ],
    );
  }

  List<Widget> _buildReviewList(List<ReviewItem> values) {
    List<Widget> list = <Widget>[];
    values.forEach((item) => list.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AuthorLabel(author: item.author),
              GestureDetector(
                onTap: () => onTap(item.author, item.content),
                child: ReviewContent(item.content),
              ),
              SizedBox(height: 8.0),
            ],
          ),
        ));
    return list;
  }
}
