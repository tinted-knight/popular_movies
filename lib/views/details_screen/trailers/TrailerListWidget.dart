import 'package:flutter/material.dart';
import 'package:popular_movies/base/logic/BaseBloc.dart';
import 'package:popular_movies/logic/TrailersBloc.dart';
import 'package:popular_movies/model/TrailerModel.dart';
import 'package:popular_movies/strings.dart';
import 'package:popular_movies/views/details_screen/SectionLabel.dart';
import 'package:popular_movies/views/details_screen/trailers/TrailerPoster.dart';
import 'package:popular_movies/views/styles/DetailsScreen.dart';

class TrailerListWidget extends StatelessWidget {
  TrailerListWidget({this.onTap});

  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    final TrailersBloc trailersBloc = BlocProvider.of<TrailersBloc>(context);

    return StreamBuilder<TrailersBlocState>(
      stream: trailersBloc.states,
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
              child: TrailerPoster(
                trailerKey: item.key,
                height: kTrailersPosterHeight,
              ),
            ),
          ),
        ));
    return list;
  }
}
