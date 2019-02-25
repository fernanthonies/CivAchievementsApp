import 'package:flutter/material.dart';
import 'package:flutter_app/services/AchievementService.dart';
import 'package:flutter_app/ui/UserWidget.dart';


void main() => runApp(MyApp(service: CivAchievementService()));

class MyApp extends StatelessWidget {
  final CivAchievementService service;

  MyApp({Key key, this.service}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Startup Name Generator',
        theme: new ThemeData(
          primaryColor: Colors.blueAccent,
        ),
        home: UserNameWidget());
  }
}
