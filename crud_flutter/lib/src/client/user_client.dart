import 'dart:convert';
import 'package:crud_flutter/src/configs/server_config.dart';
import 'package:crud_flutter/src/models/feed/feed_request.dart';
import 'package:http/http.dart' as http;

class UserClient {
  UserClient() {
    print("UserClient Initialized");
  }

  Future<dynamic> signIn(String signInRequest) async {
    final http.Response response = await http
        .post(
          ServerConfig.SERVER_HOST +
              ServerConfig.SERVER_PORT +
              '/api/adminapi/login',
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: signInRequest,
        )
        .timeout(Duration(seconds: 20));

    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  Future<dynamic> getUserListFeed(
      String jwtToken,  int userId) async {
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
