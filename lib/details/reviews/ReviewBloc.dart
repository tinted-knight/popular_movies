
import 'package:popular_movies/base/BaseBloc.dart';
import 'package:popular_movies/base/repo/repo.dart';
import 'package:popular_movies/model/ReviewModel.dart';

abstract class IReviews extends IBloc<ReviewsBlocState> {
  void loadReviews(String movieId);
}

class ReviewsBloc extends BaseBloc<ReviewsBlocState> implements IReviews {
  ReviewsBloc(Repository repository) : super(repository);

  @override
  void loadReviews(String movieId) {
    streamController.sink.add(ReviewsBlocState._reviewsLoading());
    repository.fetchReviews(movieId).then((reviews) {
      if (reviews != null) {
        streamController.sink.add(ReviewsBlocState._reviewsData(reviews));
      }
    });
  }
}

class ReviewsBlocState {
  ReviewsBlocState();

  factory ReviewsBlocState._reviewsLoading() = ReviewsStateLoading;

  factory ReviewsBlocState._reviewsData(ReviewModel reviews) = ReviewsStateData;
}

class ReviewsStateLoading extends ReviewsBlocState {}

class ReviewsStateData extends ReviewsBlocState {
  ReviewsStateData(this.reviewModel);

  final ReviewModel reviewModel;
}
