import 'dart:convert';
import 'package:crud_flutter/src/models/user/address_details.dart';

class User {
  String insertByUserId;
  String userId;
  String firstName;
  String lastName;
  String childDependentId;
  AddressDetails address;
  String userType;

  User({
    this.insertByUserId,
    this.userId,
    this.firstName,
    this.lastName,
    this.childDependentId,
    this.address,
    this.userType,
  });

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      insertByUserId: jsonData['INSERT_BY_USER_ID'],
      userId: jsonData['USER_ID'],
      firstName: jsonData['FIRST_NAME'],
      lastName: jsonData['LAST_NAME'],
      childDependentId: jsonData['CHILD_DEPENDENT_ID'],
      address: (jsonData['ADDRESS'] == null)
          ? null
          : AddressDetails.fromJson(jsonData['ADDRESS']),
      userType: jsonData['USER_TYPE'],
    );
  }

  String toJsonEncodedString() {
    return jsonEncode(<String, dynamic>{
      'INSERT_BY_USER_ID': insertByUserId,
      'USER_ID': userId,
      'FIRST_NAME': firstName,
      'LAST_NAME': lastName,
      'CHILD_DEPENDENT_ID': childDependentId,
      'ADDRESS': (address == null) ? null : address.toJsonEncodedString(),
      'USER_TYPE': userType,
    });
  }
}
