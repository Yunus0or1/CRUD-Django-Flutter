import 'dart:convert';
import 'package:crud_flutter/src/models/states/app_state.dart';
import 'package:crud_flutter/src/models/user/user.dart';
import 'package:crud_flutter/src/util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This file is responsible for all storing data in SharedPreferences
class Store {
  AppState _appState;

  final String _APP_DATA_KEY = 'APP_DATA_KEY';

  Store() {}

  Future _initAppDataFromDB() async {
    final prefs = await SharedPreferences.getInstance();
    //prefs.remove(_APP_DATA_KEY);
    if (prefs.containsKey(_APP_DATA_KEY)) {
      print("SharedPreference Key found");
      try {
        Map<String, dynamic> jsonMap =
            json.decode(prefs.getString(_APP_DATA_KEY));
        _appState = AppState.fromJsonMap(jsonMap);
      } catch (err) {
        print("SharedPreference Parse error");
        print(err);
        prefs.remove(_APP_DATA_KEY);
        _appState = new AppState();
      }
    } else {
      print("SharedPreference Key not found");
      _appState = new AppState();
    }
  }

  Future putAppData() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonMap = _appState.toJsonMap();
    prefs.setString(_APP_DATA_KEY, json.encode(jsonMap));
    print("Write sharedPreference");
  }

  Future deleteAppData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_APP_DATA_KEY);
    _appState = new AppState();
  }

  Future createUserUUID() async {
    if(appState.userUUID.isEmpty){
      appState.userUUID =  Util.createUUID();
      await putAppData();
    }else {
      print( appState.userUUID );
    }

  }

  // ----------------------------------------------------------------------- //
  // This is called before getting instance.

  static Future initStore() async {
    _instance = Store();
    await _instance._initAppDataFromDB();
  }

  // -------------------------------------------------------------------------//

  static Store _instance;

  static Store get instance => _instance;

  AppState get appState => _appState;
}
