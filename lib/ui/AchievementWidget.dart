import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/Achievement.dart';

class AchievementState extends State<AchievementWidget> {

  Container _leftSection() {
    return Container(
      height: 64,
      width: 64,
      child: ClipRRect(
          borderRadius:
          new BorderRadius.circular(5.0),
          child: CachedNetworkImage(
            imageUrl: widget.cheevo.imageUrl,
            placeholder: (context, url) =>
            new CircularProgressIndicator(),
          )),
    );
  }

  Expanded _rightSection() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.cheevo.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
            Text(
                widget.cheevo.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          _leftSection(),
          _rightSection()
        ],
      ),
    );
  }
}

class AchievementWidget extends StatefulWidget {
  final Achievement cheevo;

  const AchievementWidget({Key key, this.cheevo}): super(key: key);

  @override
  AchievementState createState() => new AchievementState();
}