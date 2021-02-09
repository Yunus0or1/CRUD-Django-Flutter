import 'dart:async';
import 'package:flutter/widgets.dart';


class AppVariableStates {
  BuildContext context;
  bool loginWithReferral = false;
  String dynamicLink = "";
  GlobalKey<NavigatorState> navigatorKey;
  Function submitFunction;

  static AppVariableStates _appVaryState;
  static AppVariableStates get instance =>
      _appVaryState ??= AppVariableStates();
}
