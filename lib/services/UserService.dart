import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_app/data/User.dart';

class UserService {
  Future<User> fetchSteamUser(String userName) async {
    final userResponse = await http.get(
        "http://localhost:8080/user/$userName/userId",
        headers: {"Accept": "application/json"});

    if (userResponse.statusCode == 200) {
      return User.fromJson(json.decode(userResponse.body));
    } else {
      throw Exception('failed request');
    }
  }
}

