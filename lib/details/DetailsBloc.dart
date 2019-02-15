import 'package:popular_movies/base/repo/repo.dart';
import 'package:popular_movies/details/reviews/ReviewBloc.dart';
import 'package:popular_movies/details/trailers/TrailersBloc.dart';

class DetailsBloc {
  DetailsBloc(Repository repository)
      : _iTrailers = TrailersBloc(repository),
        _iReviews = ReviewsBloc(repository);

  void load(String movieId) {
    _iTrailers.loadTrailers(movieId);
    _iReviews.loadReviews(movieId);
  }

  final ITrailers _iTrailers;
  final IReviews _iReviews;

  Stream<TrailersBlocState> get trailers => _iTrailers.states;

  Stream<ReviewsBlocState> get reviews => _iReviews.states;
}
