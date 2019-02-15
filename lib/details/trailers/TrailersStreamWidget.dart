import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:popular_movies/base/BaseStreamWidget.dart';
import 'package:popular_movies/details/SectionLabel.dart';
import 'package:popular_movies/details/trailers/TrailersBloc.dart';
import 'package:popular_movies/model/TrailerModel.dart';
import 'package:popular_movies/strings.dart';

class TrailersStreamWidget extends BaseStreamWidget<TrailersBlocState> {
  TrailersStreamWidget(Stream<TrailersBlocState> states, {this.onTap})
      : super(states);

  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TrailersBlocState>(
      stream: states,
      initialData: TrailersStateLoading(),
      builder: (_, snapshot) {
        if (snapshot.data is TrailersStateLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data is TrailersStateValues) {
          TrailersStateValues state = snapshot.data;
          return _buildTrailers(state.trailers);
        }
      },
    );
  }

  Widget _buildTrailers(List<TrailerItem> values) {
    if (values.length == 0) return SizedBox(height: 1.0);
    return Column(
      children: <Widget>[
        SectionLabel(StrRes.trailers),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: _buildTrailersRow(values)),
        ),
      ],
    );
  }

  List<Widget> _buildTrailersRow(List<TrailerItem> values) {
    List<Widget> list = <Widget>[];
    values.forEach((item) => list.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => onTap(item.key),
              child: _TrailerPoster(trailerKey: item.key),
            ),
          ),
        ));
    return list;
  }
}

class _TrailerPoster extends StatelessWidget {
  final String trailerKey;

  const _TrailerPoster({Key key, this.trailerKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: 100.0,
      imageUrl: "https://img.youtube.com/vi/$trailerKey/0.jpg",
      placeholder: CircularProgressIndicator(),
      errorWidget: Icon(Icons.error),
    );
  }
}
