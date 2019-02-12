import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:popular_movies/base/repo/repo.dart';
import 'package:popular_movies/details/overview.dart';
import 'package:popular_movies/details/trailers/TrailersBloc.dart';
import 'package:popular_movies/model/TrailerModel.dart';
import 'package:popular_movies/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class TrailersWidget extends StatefulWidget {
  TrailersWidget(this._repository, this._movieId);

  final Repository _repository;
  final num _movieId;

  @override
  _TrailersWidgetState createState() {
    return new _TrailersWidgetState();
  }
}

class _TrailersWidgetState extends State<TrailersWidget> {
  ITrailers _trailersBloc;

  @override
  void initState() {
    _trailersBloc = TrailersBloc(widget._repository);
    _trailersBloc.loadTrailers(widget._movieId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TrailersBlocState>(
      stream: _trailersBloc.states,
      initialData: TrailersStateLoading(),
      builder: (_, snapshot) {
        if (snapshot.data is TrailersStateLoading) {
          return _buildLoading();
        }
        if (snapshot.data is TrailersStateValues) {
          TrailersStateValues data = snapshot.data;
          return _buildContent(data.trailers);
        }
      },
    );
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildContent(List<TrailerItem> values) {
    if (values.length == 0) return SizedBox(height: 1.0);
    return Column(
      children: <Widget>[
        SectionLabel(StrRes.trailers),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: _buildRow(values)),
        ),
      ],
    );
  }

  List<Widget> _buildRow(List<TrailerItem> values) {
    List<Widget> list = <Widget>[];
    values.forEach((item) => list.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => _launchUrl(item.key),
              child: _TrailerPoster(trailerKey: item.key),
            ),
          ),
        ));
    return list;
  }

  void _launchUrl(String key) async {
    var url = "https://www.youtube.com/watch?v=$key";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Cannot launch");
    }
  }

  @override
  void dispose() {
    _trailersBloc.dispose();
    super.dispose();
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
