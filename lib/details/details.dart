import 'package:flutter/material.dart';
import 'package:popular_movies/base/repo/repo.dart';
import 'package:popular_movies/details/FullScreenPoster.dart';
import 'package:popular_movies/details/overview.dart';
import 'package:popular_movies/details/poster.dart';
import 'package:popular_movies/details/reviews/ReviewsWidget.dart';
import 'package:popular_movies/details/trailers/TrailersWidget.dart';
import 'package:popular_movies/model/tmdb.dart';
import 'package:popular_movies/styles/DetailsScreen.dart';

class DetailsSliveredAppBar extends StatefulWidget {
  final Result movie;

  const DetailsSliveredAppBar({Key key, this.movie}) : super(key: key);

  @override
  _DetailsSliveredAppBarState createState() {
    return new _DetailsSliveredAppBarState(movie);
  }
}

class _DetailsSliveredAppBarState extends State<DetailsSliveredAppBar> {
  final Result movie;

  _DetailsSliveredAppBarState(this.movie);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
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
                          builder: (_) =>
                              FullScreenPoster(movie.posterPath, movie.id)),
                    );
                  },
                  child: PosterWithInfo(movie),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(AppBar(
                title: Text(movie.title),
              )),
            )
          ];
        },
        body: _buildMainContent(),
      ),
    );
  }

  Widget _buildMainContent() {
    return ListView(
      children: <Widget>[
        _decorateSectionLabel(SectionLabel("Overview")),
        OverviewContent(movie.overview),
        SizedBox(height: 16.0),
        TrailersWidget(Repository(), movie.id),
        SizedBox(height: 16.0),
        ReviewsWidget(Repository(), movie.id),
      ],
    );
  }
}

Widget _decorateSectionLabel(SectionLabel label) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[label],
  );
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
