import 'package:crud_flutter/src/models/general/Enum_Data.dart';
import 'package:crud_flutter/src/models/user/user.dart';

class AppState {
  String language = ClientEnum.LANGUAGE_ENGLISH;
  User user = new User();

  AppState() {}

  AppState.fromJsonMap(Map<String, dynamic> data) {
    language = data['LANGUAGE'];
    user = User.fromJson(data['USER']);
  }

  Map<String, dynamic> toJsonMap() {
    final data = Map<String, dynamic>();
    data['LANGUAGE'] = language;
    data['USER'] = user.toJsonMap();

    return data;
  }
}
