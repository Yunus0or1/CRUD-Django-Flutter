import 'dart:convert';
import 'package:crud_flutter/src/models/user/address_details.dart';

class User {
  String id;
  String firstName;
  String lastName;
  String userType;
  AddressDetails addressDetails;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.userType,
    this.addressDetails,
  });

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
        id: jsonData['id'],
        firstName: jsonData['name'],
        lastName: jsonData['email'],
        userType: jsonData['user_type'],
        addressDetails: AddressDetails.fromJson(jsonData['address_details']));
  }

  String toJsonString() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = firstName;
    data['email'] = lastName;
    data['user_type'] = userType;
    data['address_details'] = addressDetails.toJsonEncodedString();

    return json.encode(data);
  }
}
