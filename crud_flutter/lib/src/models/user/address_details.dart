import 'dart:convert';

class AddressDetails {
  String street;
  String city;
  String state;
  String zip;

  AddressDetails({this.city, this.state, this.street, this.zip});

  factory AddressDetails.fromJson(Map<String, dynamic> jsonData) {
    return AddressDetails(
      street: jsonData['STREET'],
      city: jsonData['CITY'],
      state: jsonData['STATE'],
      zip: jsonData['ZIP'],
    );
  }

  String toJsonEncodedString() {
    return jsonEncode(<String, dynamic>{
      'STREET': street,
      'CITY': city,
      'STATE': state,
      'ZIP': zip,
    });
  }
}
