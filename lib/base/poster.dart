import 'package:flutter/material.dart';

abstract class BasePosterImage extends StatelessWidget {
  final String posterPath;

  BasePosterImage(this.posterPath);

  String getPosterUrl() {
    final String baseUrl = "http://image.tmdb.org/t/p/";
    final String qualifier = "w500";
    return baseUrl + qualifier + posterPath;
  }
}
