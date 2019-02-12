import 'package:flutter/material.dart';

abstract class BasePosterImage extends StatelessWidget {
  final String _baseUrl = "http://image.tmdb.org/t/p/";
  final String _qualifier = "w500";
  final String posterPath;

  BasePosterImage(this.posterPath);

  String get posterUrl => _baseUrl + _qualifier + posterPath;
}
