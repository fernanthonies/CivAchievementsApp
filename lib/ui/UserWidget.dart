import 'package:flutter/material.dart';
import 'package:flutter_app/data/Achievement.dart';
import 'package:flutter_app/data/CivGameInfo.dart';
import 'package:flutter_app/data/User.dart';
import 'package:flutter_app/services/AchievementService.dart';
import 'package:flutter_app/services/UserService.dart';
import 'package:flutter_app/ui/AchievementsListWidget.dart';

class UserState extends State<UserNameWidget> {
  final CivAchievementService _service = CivAchievementService();
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Steam User Name"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(100.0),
          ),
          Text(
            "Enter Steam User Name",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
          TextField(
            controller: textController,
            textAlign: TextAlign.center,
          ),
          RaisedButton(
            child: Text(
              "Civ VI",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              if (RegExp(r"^[0-9]+$").hasMatch(textController.text)) {
                User user = User(id: textController.text);
                _fetchGameInfo(user).then((result) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AchievementListWidget(gameInfo: result)));
                });
              } else {
                UserService()
                    .fetchSteamUser(textController.text)
                    .then((result) {
                  _fetchGameInfo(result).then((result) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AchievementListWidget(gameInfo: result)));
                  });
                });
              }
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<CivGameInfo> _fetchGameInfo(User user) async {
    AchievementList suggested = await _service.fetchSuggestedAchievements(user);
    AchievementList unlocked = await _service.fetchUnlockedAchievements(user);
    AchievementList locked  = await _service.fetchLockedAchievements(user);

    return CivGameInfo(suggested: suggested, unlocked: unlocked, locked: locked);
  }
}

class UserNameWidget extends StatefulWidget {
  @override
  UserState createState() => new UserState();
}
