import 'package:popular_movies/base/logic/BaseBloc.dart';
import 'package:popular_movies/logic/repository/Repository.dart';
import 'package:popular_movies/model/ReviewModel.dart';

class ReviewsBloc extends BaseBloc<ReviewsBlocState> {
  ReviewsBloc(Repository repository) : super(repository);

  void loadReviews(String movieId) {
    streamController.sink.add(ReviewsBlocState._reviewsLoading());
    repository.fetchReviews(movieId).then((reviews) {
      if (reviews != null && reviews.length > 0) {
        streamController.sink.add(ReviewsBlocState._reviewsData(reviews));
      }
    });
  }
}

class ReviewsBlocState {
  ReviewsBlocState();

  factory ReviewsBlocState._reviewsLoading() = ReviewsStateLoading;

  factory ReviewsBlocState._reviewsData(List<ReviewItem> reviews) = ReviewsStateData;
}

class ReviewsStateLoading extends ReviewsBlocState {}

class ReviewsStateData extends ReviewsBlocState {
  ReviewsStateData(this.reviews);

  final List<ReviewItem> reviews;
}
