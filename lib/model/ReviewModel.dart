class ReviewModel {
  int _id;
  int _page;
  List<ReviewItem> _results;

  ReviewModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _page = json['page'];
    List<ReviewItem> temp = [];
    for (int i = 0; i < json['results'].length; i++) {
      temp.add(ReviewItem(json['results'][i]));
    }
    _results = temp;
  }

  List<ReviewItem> get results => _results;

  int get page => _page;

  int get id => _id;
}

class ReviewItem {
  String _author;
  String _id;
  String _content;
  String _url;

  ReviewItem(result) {
    _author = result['author'];
    _id = result['id'];
    _content = result['content'];
    _url = result['url'];
  }

  String get author => _author;

  String get url => _url;

  String get content => _content;

  String get id => _id;
}
