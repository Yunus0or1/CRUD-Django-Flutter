import 'dart:convert';
import 'package:crud_flutter/src/configs/server_config.dart';
import 'package:crud_flutter/src/models/feed/feed_request.dart';
import 'package:http/http.dart' as http;

class UserClient {
  UserClient() {
    print("UserClient Initialized");
  }

  Future<dynamic> getUserListFeed(String jwtToken, String userId) async {
    final http.Response response = await http.get(
      ServerConfig.SERVER_HOST +
          ServerConfig.SERVER_PORT.toString() +
          '/api/appapi/request-list/${userId}/',
      headers: {
        'token': jwtToken,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(Duration(seconds: 300));

    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  Future<dynamic> getParentList(String jwtToken, String userId) async {
    final http.Response response = await http.get(
      ServerConfig.SERVER_HOST +
          ServerConfig.SERVER_PORT.toString() +
          '/api/appapi/request-list/${userId}/',
      headers: {
        'token': jwtToken,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(Duration(seconds: 300));

    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  static UserClient _instance;
  static UserClient get instance => _instance ??= UserClient();
}
