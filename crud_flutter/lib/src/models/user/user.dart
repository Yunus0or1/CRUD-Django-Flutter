import 'dart:convert';
import 'package:crud_flutter/src/models/user/address_details.dart';

class User {
  String userId;
  String firstName;
  String lastName;
  String childDependentId;
  AddressDetails address;
  String userType;

  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.childDependentId,
    this.address,
    this.userType,
  });

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
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

  String toJsonString() {
    final data = Map<String, dynamic>();
    data['USER_ID'] = userId;
    data['FIRST_NAME'] = firstName;
    data['LAST_NAME'] = lastName;
    data['CHILD_DEPENDENT_ID'] = childDependentId;
    data['ADDRESS'] =
        (address == null) ? null : address.toJsonEncodedString();
    data['USER_TYPE'] = userType;

    return json.encode(data);
  }
}
