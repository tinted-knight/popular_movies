import 'package:flutter/material.dart';
import 'package:popular_movies/model/BackdropModel.dart';
import 'package:popular_movies/views/widgets/poster.dart';

class PosterPageViewWithIndicator extends StatefulWidget {
  final List<PosterItem> items;
  final String heroTag;

  const PosterPageViewWithIndicator({Key key, this.items, this.heroTag})
      : super(key: key);

  @override
  _PosterPageViewWithIndicatorState createState() =>
      _PosterPageViewWithIndicatorState();
}

class _PosterPageViewWithIndicatorState
    extends State<PosterPageViewWithIndicator> {
  PageController _controller;
  int _currentPage = 0;

  String get _displayPage => (_currentPage + 1).toString();

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView.builder(
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          controller: _controller,
          itemCount: widget.items.length,
          itemBuilder: (ctx, index) => _pageViewItem(
            backdrop: widget.items[index],
            heroTag: widget.heroTag,
          ),
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: Row(
            children: <Widget>[
              Text(_displayPage),
              Text(" / ${widget.items.length}"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _pageViewItem({PosterItem backdrop, String heroTag}) {
    return Stack(
      children: <Widget>[
        BackdropPosterHero(
          backdropPath: backdrop.path,
          heroTag: heroTag,
        ),
      ],
    );
  }
}
