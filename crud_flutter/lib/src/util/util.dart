import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy_app/src/models/general/Enum_Data.dart';
import 'package:pharmacy_app/src/models/order/deliver_address_details.dart';
import 'package:pharmacy_app/src/models/order/invoice_item.dart';
import 'package:pharmacy_app/src/repo/auth_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pharmacy_app/src/store/store.dart';
import 'package:pharmacy_app/src/util/en_bn_dict.dart';
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

  static String formatDateToString(DateTime dateTime) {
    return new DateFormat.yMMMMd('en_US').add_jm().format(dateTime.toUtc());
  }

  static String formatDateToStringOnlyDate(DateTime dateTime) {
    return Jiffy(dateTime.toUtc()).MMMMd;
  }

  static String formatDateToStringDateAndDay(DateTime dateTime) {
    return Jiffy(dateTime.toUtc()).EEEE + ", " + Jiffy(dateTime.toUtc()).yMMMMd;
  }

  static String formatDateToyyyy_MM_DD(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  static String formatDateToStringOnlyHourMinute(DateTime dateTime) {
    String hour;
    String minute;
    String AM_PM;

    if (dateTime.hour == 12 || dateTime.hour == 0)
      hour = 12.toString();
    else
      hour = (dateTime.hour % 12).toString();

    if (dateTime.minute >= 0 && dateTime.minute <= 9)
      minute = "0" + dateTime.minute.toString();
    else
      minute = dateTime.minute.toString();

    if (dateTime.hour >= 12)
      AM_PM = "PM";
    else
      AM_PM = "AM";

    final timeInEnglish = hour + ":" + minute + " " + AM_PM;

    return timeInEnglish;
  }

  static String createImageUUID() {
    return Uuid().v4().toString().replaceAll("-", "_") +
        "_" +
        DateTime.now().millisecondsSinceEpoch.toString();
  }

  static Future<String> uploadImageToFirebase(
      {Uint8List imageFile, String folderPath}) async {
    String downloadImageUrl = "N/A";
    Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child(folderPath + Util.createImageUUID() + ".jpg");
    UploadTask uploadTask = firebaseStorageRef.putData(imageFile);

    await uploadTask.then((TaskSnapshot snapshot) async {
      downloadImageUrl = await snapshot.ref.getDownloadURL();
    }).catchError((Object e) {
      print(e); // FirebaseException
    });
    return downloadImageUrl;
  }

  static String imageURLAsCSV({List<String> imageList}) {
    String imageUrl = "";

    for (int i = 0; i < imageList.length; i++) {
      if (i == imageList.length - 1) {
        imageUrl = imageUrl + imageList[i];
      } else {
        imageUrl = imageUrl + imageList[i] + ",";
      }
    }

    return imageUrl;
  }

  static List<String> CSVToImageList({String imagePathAsList}) {
    final List<String> imageList = imagePathAsList.split(",");
    return imageList;
  }

  static void removeFocusNode(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
      FocusManager.instance.primaryFocus.unfocus();
    }
  }

  static Uint8List convertToUIntListFromByTeData(ByteData imageBinaryData) {
    Uint8List imageData = imageBinaryData.buffer.asUint8List(
        imageBinaryData.offsetInBytes, imageBinaryData.lengthInBytes);
    return imageData;
  }

  static getDeliveryAddress(int idAddress) {
    DeliveryAddressDetails deliveryAddressDetails;

    try {
      deliveryAddressDetails = Store.instance.appState.allDeliveryAddress
          .firstWhere((deliveryAddress) => deliveryAddress.id == idAddress);
    } catch (err) {
      deliveryAddressDetails = DeliveryAddressDetails()
        ..id = 0
        ..area = "N/A"
        ..addType = "N/A"
        ..address = "N/A";
      return deliveryAddressDetails;
    }

    return deliveryAddressDetails;
  }

  static bool verifyNumberDigitOnly({String numberText}) {
    RegExp _numeric = RegExp(r'^-?[0-9]+$');
    return _numeric.hasMatch(numberText);
  }

  static getDefualtInvoice() {
    return [
      InvoiceItem()
        ..itemName = "Napa"
        ..itemQuantity = 10
        ..itemUnitPrice = 2,
      InvoiceItem()
        ..itemName = "Histasin"
        ..itemQuantity = 3
        ..itemUnitPrice = 5,
      InvoiceItem()
        ..itemName = "Seclo 40"
        ..itemQuantity = 5
        ..itemUnitPrice = 25,
    ];
  }

  static String getReferralCode() {
    return Uuid().v4().toString().split("-")[0];
  }

  static void prettyPrintJson(String input) {
    const JsonDecoder decoder = JsonDecoder();
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final dynamic object = decoder.convert(input);
    final dynamic prettyString = encoder.convert(object);
    prettyString.split('\n').forEach((dynamic element) => print(element));
  }
}
