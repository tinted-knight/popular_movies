import 'package:flutter/material.dart';
import 'package:popular_movies/base/repo/IRepository.dart';
import 'package:popular_movies/logic/BackdropBloc.dart';
import 'package:popular_movies/base/logic/BaseBloc.dart';
import 'package:popular_movies/model/BackdropModel.dart';
import 'package:popular_movies/views/widgets/AppBarTransparent.dart';
import 'package:popular_movies/views/widgets/poster.dart';

class FullscreenBackdrop extends StatelessWidget {
  const FullscreenBackdrop({@required this.movieId, @required this.repository})
      : super();

  final int movieId;
  final IRepository repository;

  @override
  Widget build(BuildContext context) {
    var backdrops = BackdropBloc(repository);
    backdrops.loadBackdrops(movieId.toString());

    return Scaffold(
      appBar: null,
      body: Stack(
        children: <Widget>[
          Center(
            child: BlocProvider(
              bloc: backdrops,
              child: StreamBuilder<BackdropBlocState>(
                stream: backdrops.states,
                initialData: BackdropStateLoading(),
                builder: _buildFromStream,
              ),
            ),
          ),
          AppBarTransparent(),
        ],
      ),
    );
  }

  Widget _buildFromStream(
      BuildContext context, AsyncSnapshot<BackdropBlocState> snapshot) {
    if (snapshot.data is BackdropStateLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (snapshot.data is BackdropStateValues) {
      BackdropStateValues state = snapshot.data;
      return _pageView(
        context: context,
        posterItems: state.values.backdrops,
        heroTag: state.values.id.toString(),
      );
    }
    return null;
  }

  Widget _pageView(
      {BuildContext context, List<PosterItem> posterItems, String heroTag}) {
    var pageController = PageController(initialPage: 0);
    return PageView.builder(
      controller: pageController,
      itemBuilder: (ctx, index) => _pageViewItem(
        context: ctx,
        path: posterItems[index].path,
        heroTag: heroTag
      ),
    );
  }

  Widget _pageViewItem({String path, BuildContext context, String heroTag}) {
    return BackdropPosterHero(
      backdropPath: path,
      heroTag: heroTag,
    );
  }
}
