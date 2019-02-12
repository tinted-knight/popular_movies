import 'package:flutter/material.dart';
import 'package:popular_movies/base/repo/repo.dart';
import 'package:popular_movies/details/overview.dart';
import 'package:popular_movies/details/reviews/ReviewBloc.dart';
import 'package:popular_movies/details/reviews/AuthorLabel.dart';
import 'package:popular_movies/details/reviews/ReviewContent.dart';
import 'package:popular_movies/model/ReviewModel.dart';
import 'package:popular_movies/strings.dart';

class ReviewsWidget extends StatefulWidget {
  ReviewsWidget(this._repository, this._movieId);

  final num _movieId;
  final Repository _repository;

  @override
  _ReviewsWidgetState createState() {
    return new _ReviewsWidgetState();
  }
}

class _ReviewsWidgetState extends State<ReviewsWidget> {
  IReviews _reviewsBloc;

  @override
  void initState() {
    _reviewsBloc = ReviewsBloc(widget._repository);
    _reviewsBloc.loadReviews(widget._movieId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<ReviewsBlocState>(
        stream: _reviewsBloc.states,
        initialData: ReviewsStateLoading(),
        builder: (_, snapshot) {
          if (snapshot.data is ReviewsStateLoading) {
            return _buildLoading();
          }
          if (snapshot.data is ReviewsStateData) {
            ReviewsStateData state = snapshot.data;
            return _buildContent(state.reviewModel.results);
          }
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildContent(List<ReviewItem> values) {
    if (values.length == 0) return SizedBox(height: 1.0);
    return Column(
      children: <Widget>[
        SectionLabel(StrRes.reviews),
        Column(children: _buildList(values))
      ],
    );
  }

  List<Widget> _buildList(List<ReviewItem> values) {
    List<Widget> list = <Widget>[];
    values.forEach((item) => list.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AuthorLabel(author: item.author),
              ReviewContent(item.content),
//              ReviewContent(
//                isExpandable: item.content.length > 100,
//                value: item.content.substring(
//                  0,
//                  item.content.length > 100 ? 100 : item.content.length,
//                ),
//              ),
              SizedBox(height: 8.0),
            ],
          ),
        ));
    return list;
  }

  @override
  void dispose() {
    _reviewsBloc.dispose();
    super.dispose();
  }
}
