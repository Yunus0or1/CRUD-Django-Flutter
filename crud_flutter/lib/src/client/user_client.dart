import 'dart:convert';
import 'package:crud_flutter/src/configs/server_config.dart';
import 'package:crud_flutter/src/models/feed/feed_request.dart';
import 'package:http/http.dart' as http;

class UserClient {
  UserClient() {
    print("UserClient Initialized");
  }

  Future<dynamic> addEditUser(String jwtToken, String addEditUserRequest) async {
    final http.Response response = await http.post(
      ServerConfig.SERVER_HOST +
          ServerConfig.SERVER_PORT.toString() +
          '/add_edit_user/',
      headers: {
        'token': jwtToken,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: addEditUserRequest
    ).timeout(Duration(seconds: 300));

    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  Future<dynamic> deleteUser(String jwtToken, String deleteUserRequest) async {
    final http.Response response = await http.post(
        ServerConfig.SERVER_HOST +
            ServerConfig.SERVER_PORT.toString() +
            '/delete_user/',
        headers: {
          'token': jwtToken,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: deleteUserRequest
    ).timeout(Duration(seconds: 300));

    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  Future<dynamic> getUserListFeed(String jwtToken, String getUserListRequest) async {
    final http.Response response = await http.post(
      ServerConfig.SERVER_HOST +
          ServerConfig.SERVER_PORT+
          '/get_user_list/',
      headers: {
        'token': jwtToken,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: getUserListRequest
    ).timeout(Duration(seconds: 300));

    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  Future<dynamic> getParentList(String jwtToken, String getParentUserListRequest) async {
    final http.Response response = await http.post(
      ServerConfig.SERVER_HOST +
          ServerConfig.SERVER_PORT.toString() +
          '/get_parent_user_list/',
      headers: {
        'token': jwtToken,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: getParentUserListRequest
    ).timeout(Duration(seconds: 300));

    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  static UserClient _instance;
  static UserClient get instance => _instance ??= UserClient();
}
