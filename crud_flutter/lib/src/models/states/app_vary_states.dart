import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:pharmacy_app/src/models/general/Enum_Data.dart';
import 'package:pharmacy_app/src/models/general/Order_Enum.dart';
import 'package:pharmacy_app/src/models/order/order.dart';

class AppVariableStates {
  String firebaseSMSToken = "";
  String orderFilterStatus = OrderEnum.ORDER_STATUS_ALL;
  String initialLanguageChoose = "LANGUAGE (ENGLISH)";
  DateTime selectedRepeatedTime = DateTime.now();
  Order order = new Order();
  BuildContext context;
  bool loginWithReferral = false;
  String dynamicLink = "";
  GlobalKey<NavigatorState> navigatorKey;
  Function submitFunction;

  static AppVariableStates _appVaryState;
  static AppVariableStates get instance =>
      _appVaryState ??= AppVariableStates();
}
