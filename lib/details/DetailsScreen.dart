import 'package:flutter/material.dart';
import 'package:popular_movies/base/BaseBloc.dart';
import 'package:popular_movies/base/repo/repo.dart';
import 'package:popular_movies/details/FavoriteLogic.dart';
import 'package:popular_movies/details/FullReviewDialog.dart';
import 'package:popular_movies/details/FullScreenPoster.dart';
import 'package:popular_movies/details/poster_with_info/PosterWithInfo.dart';
import 'package:popular_movies/details/OverviewContent.dart';
import 'package:popular_movies/details/reviews/ReviewBloc.dart';
import 'package:popular_movies/details/reviews/ReviewsListWidget.dart';
import 'package:popular_movies/details/trailers/TrailersBloc.dart';
import 'package:popular_movies/details/trailers/TrailersListWidget.dart';
import 'package:popular_movies/model/tmdb.dart';
import 'package:popular_movies/styles/DetailsScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  final Result movie;

  const DetailsScreen({this.movie});

  @override
  _DetailsScreenState createState() {
    return new _DetailsScreenState(movie);
  }
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  _DetailsScreenState(this.movie) : movieId = movie.id.toString();

  final Result movie;
  final Repository repository = Repository();
  final String movieId;

  TrailersBloc trailersBloc;
  ReviewsBloc reviewsBloc;
  FavoriteLogic favoriteLogic;

  AnimationController controller;

  @override
  void initState() {
    super.initState();

    trailersBloc = TrailersBloc(repository);
    trailersBloc.loadTrailers(movieId);

    reviewsBloc = ReviewsBloc(repository);
    reviewsBloc.loadReviews(movieId);

    favoriteLogic = FavoriteLogic(repository: repository, movie: movie);

    controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            _buildAppBar(),
            _buildPersistentHeader(),
          ];
        },
        body: _buildMainContent(),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: false,
      snap: false,
      floating: false,
      expandedHeight: kAppBarHeight,
      flexibleSpace: FlexibleSpaceBar(
        background: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => FullScreenPoster(movie.posterPath, movie.id)),
            );
          },
          child: PosterWithInfo(movie: movie, controller: controller),
        ),
      ),
    );
  }

  Widget _buildPersistentHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(AppBar(
        title: Text(movie.title),
        actions: <Widget>[
          IconButton(
            onPressed: () => favoriteLogic.markFavorite(),
            icon: StreamBuilder<FavoriteState>(
              stream: favoriteLogic.states,
              initialData: FavoriteState.inProgress,
              builder: (_, snapshot) {
                switch (snapshot.data) {
                  case FavoriteState.marked:
                    return Icon(Icons.favorite);
                  case FavoriteState.notMarked:
                    return Icon(Icons.favorite_border);
                  case FavoriteState.inProgress:
                    return Container(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(),
                    );
                }
              },
            ),
          )
        ],
      )),
    );
  }

  Widget _buildMainContent() {
    return ListView(
      children: <Widget>[
        OverviewContent(movie.overview),
        SizedBox(height: 16.0),
        BlocProvider(
          bloc: trailersBloc,
          child: TrailersListWidget(onTap: _launchUrl),
        ),
        SizedBox(height: 16.0),
        BlocProvider(
          bloc: reviewsBloc,
          child: ReviewsListWidget(onTap: _showFullReview),
        ),
      ],
    );
  }

  void _launchUrl(String key) async {
    var url = "https://www.youtube.com/watch?v=$key";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Cannot launch");
    }
  }

  void _showFullReview(String author, String content) {
    controller.reset();
    controller.forward();

    Animation<double> dialogAnim =
        CurvedAnimation(parent: controller, curve: Interval(0.0, 0.5));

    Widget dialog = GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: FullReviewDialog(author: author, content: content),
    );

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return AnimatedBuilder(
          animation: dialogAnim,
          builder: (_, child) => FractionallySizedBox(
                widthFactor: 1.0,
                heightFactor: dialogAnim.value,
                child: dialog,
              ),
          child: dialog,
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    favoriteLogic.dispose();
    super.dispose();
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final AppBar _appBar;
  final _statusBarHeight = 24.0;

  _SliverAppBarDelegate(this._appBar);

  @override
  double get maxExtent => _appBar.preferredSize.height + _statusBarHeight;

  @override
  double get minExtent => _appBar.preferredSize.height + _statusBarHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _appBar;
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
