import 'package:flutter_app/data/Achievement.dart';

class CivGameInfo {
  final AchievementList suggested;
  final AchievementList unlocked;
  final AchievementList locked;

  CivGameInfo({this.suggested, this.unlocked, this.locked});

  operator [](int i) {
    switch(i) {
      case 0: {
        return suggested;
      }
      case 1: {
        return unlocked;
      }
      case 2: {
        return locked;
      }
      default: {
        throw IndexError(i, "Civ Game Info only has 3 elements");
      }
    }
  }
}