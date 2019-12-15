class BackdropModel {
  int _id;
  List<PosterItem> _backdrops;
  List<PosterItem> _posters;

  BackdropModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    List<PosterItem> temp = [];
    for (int i = 0; i < json['backdrops'].length; i++) {
      temp.add(PosterItem(json['backdrops'][i]));
    }
    _backdrops = temp;
  }

  List<PosterItem> get backdrops => _backdrops;
}

class PosterItem {
  String _filePath;
  int _height;
  int _width;
  double _aspectRatio;

  PosterItem(result) {
    _filePath = result['file_path'];
    _height = result['height'];
    _width = result['width'];
    _aspectRatio = result['aspect_ratio'];
  }

  String get path => _filePath;

  int get height => _height;

  int get width => _width;

  double get aspectRatio => _aspectRatio;
}
