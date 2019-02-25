import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_app/data/User.dart';
import 'package:flutter_app/data/Achievement.dart';

class CivAchievementService {

  Future<AchievementList> fetchUnlockedAchievements(User user) async {

    final cheevoResponse = await http.get(
        "http://localhost:8080/achievements/civ6/unlocked?userId=${user.id}",
        headers: {"Accept": "application/json"});

    if (cheevoResponse.statusCode == 200) {
      return AchievementList.fromJson(json.decode(cheevoResponse.body));
    } else {
      throw Exception('Achievement request failed');
    }
  }

  Future<AchievementList> fetchLockedAchievements(User user) async {
    final cheevoResponse = await http.get(
        "http://localhost:8080/achievements/civ6/locked?userId=${user.id}",
        headers: {"Accept": "application/json"});

    if (cheevoResponse.statusCode == 200) {
      return AchievementList.fromJson(json.decode(cheevoResponse.body));
    } else {
      throw Exception('Achievement request failed');
    }
  }
}