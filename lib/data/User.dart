class User {
  final String id;

  User({this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id']);
  }
}