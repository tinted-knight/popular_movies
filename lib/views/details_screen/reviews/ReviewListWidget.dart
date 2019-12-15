import 'package:flutter/material.dart';
import 'package:popular_movies/base/logic/BaseBloc.dart';
import 'package:popular_movies/views/details_screen/SectionLabel.dart';
import 'package:popular_movies/views/details_screen/reviews/AuthorLabel.dart';
import 'package:popular_movies/logic/ReviewBloc.dart';
import 'package:popular_movies/views/details_screen/reviews/ReviewContent.dart';
import 'package:popular_movies/model/ReviewModel.dart';
import 'package:popular_movies/strings.dart';

class ReviewListWidget extends StatelessWidget {
  ReviewListWidget({this.onTap});

  final Function(String, String) onTap;

  @override
  Widget build(BuildContext context) {
    print('ReviewListWidget.build');
    final ReviewsBloc reviewsBloc = BlocProvider.of<ReviewsBloc>(context);

    return StreamBuilder<ReviewsBlocState>(
      stream: reviewsBloc.states,
      initialData: ReviewsStateLoading(),
      builder: (_, snapshot) {
        if (snapshot.data is ReviewsStateLoading) {
          print('review, loading');
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data is ReviewsStateData) {
          print('review, data');
          ReviewsStateData state = snapshot.data;
          return _buildReviews(state.reviews);
        }
        if (snapshot.data is ReviewsStateEmpty) {
          print('review, empty');
          return Container(width: 0.0, height: 0.0);
        }
        return null;
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
