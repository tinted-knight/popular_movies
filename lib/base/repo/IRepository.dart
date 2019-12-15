abstract class IRepository<TMovie, TTrailer, TReview, TBackdrop> {
  Future<List<TMovie>> fetchPopularMovies();

  Future<List<TMovie>> fetchTopRatedMovies();

  Future<List<TMovie>> fetchFavorites();

  Future<List<TTrailer>> fetchTrailers(String movieId);

  Future<List<TReview>> fetchReviews(String movieId);

  Future<List<TBackdrop>> fetchBackdrops(String movieId);

  Future<bool> switchFavoriteMark(TMovie movie, bool currentMark);

  Future<bool> checkIsFavorite(String movieId);
}

abstract class ILocalStorage<TMovie> {
  Future<bool> switchFavoriteMark(TMovie movie, bool currentMark);

  Future<bool> checkIsFavorite(String movieId);

  Future<List<TMovie>> getFavoritesList();
}
