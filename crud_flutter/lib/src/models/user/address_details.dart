import 'dart:convert';

class AddressDetails {
  String street;
  String city; // Address Type: Home, Office
  String state;
  String zip;

  AddressDetails({this.city, this.state, this.street, this.zip});

  factory AddressDetails.fromJson(Map<String, dynamic> jsonData) {
    return AddressDetails(
      street: jsonData['street'],
      city: jsonData['city'],
      state: jsonData['state'],
      zip: jsonData['zip'],
    );
  }

  String toJsonEncodedString() {
    return jsonEncode(<String, dynamic>{
      'street': street,
      'city': city,
      'state': state,
      'zip': zip,
    });
  }
}
