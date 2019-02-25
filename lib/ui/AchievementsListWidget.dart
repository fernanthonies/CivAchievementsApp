import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/Achievement.dart';
import 'package:flutter_app/data/User.dart';
import 'package:flutter_app/services/AchievementService.dart';
import 'package:flutter_app/ui/AchievementWidget.dart';

class AchievementState extends State<AchievementListWidget> {
  final CivAchievementService _service = CivAchievementService();
  List<Widget> _cheevoList;

  AchievementState() {
    _cheevoList = new List<Widget>();
  }

  @override
  void initState() {
    _generateCheevoList();
    super.initState();
  }

  _buildList(AchievementList list) {
    List<Widget> content = [];
    for (Achievement cheevo in list.achievements) {
      content.add(AchievementWidget(cheevo: cheevo));
    }

    return content;
  }

  _generateAchievementListWidget(Future<AchievementList> future) {
    return FutureBuilder<AchievementList>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: _buildList(snapshot.data),
          );
        }  else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  void _generateCheevoList() {
    _cheevoList.add(_generateAchievementListWidget(_service.fetchUnlockedAchievements(widget.user)));
    _cheevoList.add(_generateAchievementListWidget(_service.fetchLockedAchievements(widget.user)));
  }

  @override
  Widget build(BuildContext context) {
    if (_cheevoList.length > 0) {
      return Scaffold(
        appBar: AppBar(title: Text("Cheevo App")),
        body: ListView.builder(
          itemCount: _cheevoList.length,
            itemBuilder: (context, i) {
              return ExpansionTile(
                title: Text("Achievements"),
                children: <Widget>[
                  Column(
                    children: _cheevoList[i]
                  )
                ],
              );
            }
        ),
//        body: Column(
//          children: <Widget>[
//            Center(
//              child: Expanded(
//                child: ListView.builder(
//                    itemCount: _cheevoList.length,
//                    itemBuilder: (context, i) {
//                      return _cheevoList[i];
//                    }),
//              ),
//            )
//
//          ],
//        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: Text("Cheevo App")),
        body: CircularProgressIndicator(),
      );
    }

  }

  FutureBuilder<AchievementList> _cheevoFuture(Future<AchievementList> future) {
    return FutureBuilder<AchievementList>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: snapshot.data.achievements.length,
                  itemBuilder: (context, i) {
                    return Card(
                        margin: EdgeInsets.all(4.0),
                        child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 64,
                                  width: 64,
                                  child: ClipRRect(
                                      borderRadius:
                                          new BorderRadius.circular(5.0),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data.achievements[i].imageUrl,
                                        placeholder: (context, url) =>
                                            new CircularProgressIndicator(),
                                      )),
                                ),
                                Padding(padding: EdgeInsets.all(8.0)),
                                Expanded(
                                    child: Column(
                                  children: <Widget>[
                                    Text(snapshot.data.achievements[i].title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        snapshot
                                            .data.achievements[i].description,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 10))
                                  ],
                                ))
                              ],
                            )));
                  }),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class AchievementListWidget extends StatefulWidget {
  final User user;

  const AchievementListWidget({Key key, this.user}) : super(key: key);

  @override
  AchievementState createState() => new AchievementState();
}
