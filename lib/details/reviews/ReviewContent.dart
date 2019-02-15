import 'package:flutter/material.dart';
import 'package:popular_movies/styles/DetailsScreen.dart';

class ReviewContent extends StatefulWidget {
  final String value;

  ReviewContent(this.value);

  @override
  _ReviewContentState createState() {
    return new _ReviewContentState(this.value, this.value.length > 100);
  }
}

class _ReviewContentState extends State<ReviewContent>
    with SingleTickerProviderStateMixin {
  _ReviewContentState(this.content, this.isExpandable);

  final bool isExpandable;
  final String content;

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    String showValue = widget.value;
    if (isExpandable && !_isExpanded)
      showValue = widget.value.substring(0, kReviewLimit);
    return AnimatedSize(
      duration: Duration(milliseconds: 100),
      vsync: this,
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: kReviewBgColor,
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
              child: Text(
                showValue,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.body2.copyWith(height: 1.2),
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: _expandControl(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _expandControl() {
    if (!isExpandable) return SizedBox(height: 0.0);

    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0.0),
      child: Icon(Icons.more_horiz, color: Colors.white70),
    );
  }

  @override
  void dispose() {
//    _controller.dispose();
    super.dispose();
  }
}
