import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ItemWidget extends StatelessWidget {
  final String posterPath;

  ItemWidget({this.posterPath});

  @override
  Widget build(BuildContext context) {
    return new CachedNetworkImage(
      imageUrl: _getPosterUrl(),
      placeholder: new CircularProgressIndicator(),
      errorWidget: new Icon(Icons.error),
      fit: BoxFit.fitWidth,
    );
  }

  String _getPosterUrl() {
    final String baseUrl = "http://image.tmdb.org/t/p/";
    final String qualifier = "w500";
    return baseUrl + qualifier + posterPath;
  }
}
