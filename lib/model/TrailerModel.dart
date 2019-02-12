class TrailerModel {
  int _id;
  List<TrailerItem> _trailers;

  TrailerModel.fromJson(Map<String, dynamic> json) {
    _id = json["id"];
    List<TrailerItem> temp = [];
    for (int i = 0; i < json["results"].length; i++) {
      temp.add(TrailerItem(json["results"][i]));
    }
    _trailers = temp;
  }

  List<TrailerItem> get trailers => _trailers;

  int get id => _id;

}

class TrailerItem {
  String _id;
  String _iso_639_1;
  String _iso_3166_1;
  String _key;
  String _name;
  String _site;
  int _size;
  String _type;

  TrailerItem(result) {
    _id = result["id"];
    _iso_639_1 = result["iso_639_1"];
    _iso_3166_1 = result["iso_3166_1"];
    _key = result["key"];
    _name = result["name"];
    _site = result["site"];
    _size = result["size"];
    _type = result["type"];
  }

  String get type => _type;

  int get size => _size;

  String get site => _site;

  String get name => _name;

  String get key => _key;

  String get iso_3166_1 => _iso_3166_1;

  String get iso_639_1 => _iso_639_1;

  String get id => _id;
}
