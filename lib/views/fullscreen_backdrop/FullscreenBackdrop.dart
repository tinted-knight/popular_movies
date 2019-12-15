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
      return _pageView(state.backdropItems, context);
    }
    return null;
  }

  Widget _pageView(List<PosterItem> posterItems, BuildContext context) {
    List<Widget> backdropPaths = [];
    posterItems.forEach(
        (item) => backdropPaths.add(_pageViewItem(item.path, context)));

    var pageController = PageController(initialPage: 0);
    return PageView.builder(
      controller: pageController,
      itemBuilder: (ctx, index) => _pageViewItem(posterItems[index].path, ctx),
    );
  }

  Widget _pageViewItem(String path, BuildContext context) {
    return BackdropPosterHero(
      backdropPath: path,
      heroTag: path,
    );
  }
}
