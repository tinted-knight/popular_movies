import 'package:flutter/material.dart';
import 'package:popular_movies/base/repo/repo.dart';
import 'package:popular_movies/details/DetailsBloc.dart';
import 'package:popular_movies/details/FullReviewDialog.dart';
import 'package:popular_movies/details/FullScreenPoster.dart';
import 'package:popular_movies/details/SectionLabel.dart';
import 'package:popular_movies/details/overview.dart';
import 'package:popular_movies/details/PosterWithInfo.dart';
import 'package:popular_movies/details/reviews/ReviewsStreamWidget.dart';
import 'package:popular_movies/details/trailers/TrailersStreamWidget.dart';
import 'package:popular_movies/model/tmdb.dart';
import 'package:popular_movies/styles/DetailsScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsSliveredAppBarBloc extends StatefulWidget {
  final Result movie;

  const DetailsSliveredAppBarBloc({Key key, this.movie}) : super(key: key);

  @override
  _DetailsSliveredAppBarBlocState createState() {
    return new _DetailsSliveredAppBarBlocState(movie);
  }
}

class _DetailsSliveredAppBarBlocState extends State<DetailsSliveredAppBarBloc>
    with SingleTickerProviderStateMixin {
  _DetailsSliveredAppBarBlocState(this.movie) : _repository = Repository();

  final Result movie;
  DetailsBloc _detailsBloc;
  final Repository _repository;

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _detailsBloc = DetailsBloc(_repository);
    _detailsBloc.load(movie.id.toString());
    _controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            _builAppBar(),
            _buildPersistentHeader(),
          ];
        },
        body: _buildMainContent(),
      ),
    );
  }

  Widget _builAppBar() {
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
          child: PosterWithInfo(movie: movie, controller: _controller),
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
            onPressed: () {},
            icon: Icon(Icons.favorite_border),
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
        TrailersStreamWidget(
          _detailsBloc.trailers,
          onTap: _lauchUrl,
        ),
        SizedBox(height: 16.0),
        ReviewsStreamWidget(
          _detailsBloc.reviews,
          onTap: _showFullReview,
        ),
      ],
    );
  }

  void _lauchUrl(String key) async {
    var url = "https://www.youtube.com/watch?v=$key";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Cannot launch");
    }
  }

  void _showFullReview(String author, String content) {
    _controller.reset();
    _controller.forward();

    Animation<double> dialogAnim =
        CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.5));

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
    _controller.dispose();
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
