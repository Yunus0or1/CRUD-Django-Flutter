import 'dart:convert';

import 'package:crud_flutter/src/models/states/app_vary_states.dart';
import 'package:crud_flutter/src/store/store.dart';


class User {
  int id;
  String name;
  String email;
  String phone;
  String userType;
  String token;
  String dynamicReferralLink;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.userType,
      this.token,
      this.dynamicReferralLink});

  User.blank()
      : id = null,
        name = "",
        email = "",
        phone = "",
        token = "",
        dynamicReferralLink = "";

  User.none()
      : id = null,
        name = "",
        email = "",
        phone = "",
        token = "",
        dynamicReferralLink = "";

  User.basic()
      : id = 1,
        name = Store.instance.appState.user.name,
        email = Store.instance.appState.user.email,
        phone = Store.instance.appState.user.phone,
        token = "custom-token-api",
        dynamicReferralLink = AppVariableStates.instance.dynamicLink;

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      id: jsonData['id'],
      name: jsonData['name'],
      email: jsonData['email'],
      phone: jsonData['phone'],
      userType: jsonData['user_type'],
      token: jsonData['token'],
      dynamicReferralLink: jsonData['dynamic_referral_link'],
    );
  }

  String toJsonString() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['user_type'] = userType;
    data['token'] = token;
    data['dynamic_referral_link'] = dynamicReferralLink;
    return json.encode(data);
  }

  Map<String, dynamic> toJsonMap() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['user_type'] = userType;
    data['token'] = token;
    data['dynamic_referral_link'] = dynamicReferralLink;
    return data;
  }
}
