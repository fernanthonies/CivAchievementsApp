import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/Achievement.dart';
import 'package:flutter_app/data/CivGameInfo.dart';
import 'package:flutter_app/ui/AchievementWidget.dart';

class AchievementState extends State<AchievementListWidget> {

  _buildList(AchievementList list) {
    List<Widget> content = [];
    for (Achievement cheevo in list.achievements) {
      content.add(AchievementWidget(cheevo: cheevo));
      //content.add(Text("test1"));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cheevo App")),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, i) {
            return ExpansionTile(
              title: Text(widget.gameInfo[i].title),
              initiallyExpanded: widget.gameInfo[i].expanded,
              children: <Widget>[
                Column(
                    children: _buildList(widget.gameInfo[i])
                )
              ],
            );
          }
      ),
    );
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
  final CivGameInfo gameInfo;

  const AchievementListWidget({Key key, this.gameInfo}) : super(key: key);

  @override
  AchievementState createState() => new AchievementState();
}
