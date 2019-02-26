class Achievement {
  final String title;
  final String description;
  final String imageUrl;
  final String achievementType;
  final bool locked;

  Achievement({this.title, this.description, this.imageUrl, this.achievementType, this.locked});

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      achievementType: json['achievementType'],
      locked: json['locked']
    );
  }
}

class AchievementList {
  String title;
  bool expanded;
  final List<Achievement> achievements;

  AchievementList({this.title, this.achievements, this.expanded});

  factory AchievementList.fromJson(List<dynamic> json) {
    List<Achievement> achievements = json.map((a) => Achievement.fromJson(a)).toList();
    return new AchievementList(achievements: achievements);
  }
}