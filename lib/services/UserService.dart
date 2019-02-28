import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_app/data/User.dart';

class UserService {

  final String apiUrl = "http://api.fernanthonies.com:8080";

  Future<User> fetchSteamUser(String userName) async {
    final userResponse = await http.get(
        "$apiUrl/user/$userName/userId",
        headers: {"Accept": "application/json"});

    if (userResponse.statusCode == 200) {
      return User.fromJson(json.decode(userResponse.body));
    } else {
      throw Exception('failed request');
    }
  }
}

