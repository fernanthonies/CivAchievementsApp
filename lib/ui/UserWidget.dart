import 'package:flutter/material.dart';
import 'package:flutter_app/data/User.dart';
import 'package:flutter_app/services/UserService.dart';
import 'package:flutter_app/ui/AchievementsListWidget.dart';

class UserState extends State<UserNameWidget> {
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
            onPressed: () {
              if ( RegExp(r"^[0-9]+$").hasMatch(textController.text)) {
                User user = User(id: textController.text);
                Navigator.push(context, MaterialPageRoute(builder: (context) => AchievementListWidget(user: user)));
              } else {
                UserService().fetchSteamUser(textController.text).then((result) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AchievementListWidget(user: result)));
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
}

class UserNameWidget extends StatefulWidget {
  @override
  UserState createState() => new UserState();
}
