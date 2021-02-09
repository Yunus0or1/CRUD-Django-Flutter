import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:crud_flutter/src/models/general/Enum_Data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';
import 'package:intl/intl.dart';

class Util {
  static Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static String getStaticImageURL() {
    return "https://firebasestorage.googleapis.com/v0/b/pharmacy-project-419ca.appspot.com/o/static%2Fdefault.jpg?alt=media&token=9d286a17-2bdf-4a28-8a6b-15ac30c26c09";
  }

  static showSnackBar(
      {GlobalKey<ScaffoldState> scaffoldKey, String message, int duration}) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: duration ?? 3000),
    ));
  }

  static Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  static Color greenishColor() {
    String hexColor = "#1BC0CB";
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  static Color purplishColor() {
    String hexColor = "#473FA8";
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  static Color redishColor() {
    String hexColor = "#FA5353";
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  static Future<void> getPermissions() async {
    await Permission.camera.request();
    await Permission.storage.request();
    await Permission.mediaLibrary.request();
  }

  static Future<void> handleErrorResponse(
      {String errorResponseCode,
      BuildContext context,
      GlobalKey<ScaffoldState> scaffoldKey,
      int awaitDurationMiliSecond = 0}) async {
    if (errorResponseCode == ClientEnum.RESPONSE_UNAUTHORIZED) {
      // await AuthRepo.instance.logout();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
    // This Future delay is needed when we render something from FutureBuilder and let that build the UI first.
    await Future.delayed(new Duration(milliseconds: awaitDurationMiliSecond));
    if (errorResponseCode != ClientEnum.RESPONSE_CONNECTION_ERROR) {
      Util.showSnackBar(
          scaffoldKey: scaffoldKey,
          message: "Something went wrong. Please try again.");
    }
    return;
  }

  static void removeFocusNode(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
      FocusManager.instance.primaryFocus.unfocus();
    }
  }

  static void prettyPrintJson(String input) {
    const JsonDecoder decoder = JsonDecoder();
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final dynamic object = decoder.convert(input);
    final dynamic prettyString = encoder.convert(object);
    prettyString.split('\n').forEach((dynamic element) => print(element));
  }
}
