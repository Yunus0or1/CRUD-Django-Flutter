import 'package:crud_flutter/src/models/general/Enum_Data.dart';
import 'package:crud_flutter/src/models/user/user.dart';

class AppState {
  String userUUID = "";
  String jwtToken = "";

  AppState() {}

  AppState.fromJsonMap(Map<String, dynamic> data) {
    userUUID = data['USER_UUID'];
    jwtToken = data['JWT_TOKEN'];
  }

  Map<String, dynamic> toJsonMap() {
    final data = Map<String, dynamic>();
    data['USER_UUID'] = userUUID;
    data['JWT_TOKEN'] = jwtToken;
    return data;
  }
}
