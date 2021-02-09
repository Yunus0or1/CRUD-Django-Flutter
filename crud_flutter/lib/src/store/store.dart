import 'dart:convert';
import 'package:pharmacy_app/src/models/general/Enum_Data.dart';
import 'package:pharmacy_app/src/models/order/deliver_address_details.dart';
import 'package:pharmacy_app/src/models/states/app_state.dart';
import 'package:pharmacy_app/src/models/states/app_vary_states.dart';
import 'package:pharmacy_app/src/models/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  setPhoneNumber(String phoneNumber) {
    appState.user.phone = phoneNumber;
    putAppData();
  }

  setDeliveryAddress(DeliveryAddressDetails deliveryAddressDetails) async {
    appState.allDeliveryAddress.add(deliveryAddressDetails);
    putAppData();
  }

  deleteDeliveryAddress(DeliveryAddressDetails deliveryAddressDetails) async {
    appState.allDeliveryAddress.remove(deliveryAddressDetails);
    putAppData();
  }

  setFirebasePushNotificationToken(String firebasePushNotificationToken) async {
    appState.firebasePushNotificationToken = firebasePushNotificationToken;
    await putAppData();
  }

  setReferralCode(String referralCode) async {
    // Even if a user does not login first time, referral code will exist until
    // he login with that referral code
    appState.referralCode = referralCode;
    await putAppData();
  }

  setDynamicReferralLink(String deepLink)async {
    appState.user.dynamicReferralLink = deepLink;
    await putAppData();
  }

  getFirebasePushNotificationToken() {
    return appState.firebasePushNotificationToken;
  }

  Future updateLanguage({String languageOption}) async {
    if (languageOption == ClientEnum.LANGUAGE_ENGLISH) {
      appState.language = ClientEnum.LANGUAGE_BANGLA;
    } else if (languageOption == ClientEnum.LANGUAGE_BANGLA) {
      appState.language = ClientEnum.LANGUAGE_ENGLISH;
    }
    await putAppData();
  }

  Future updateUser(User user) async {
    appState.user = user;
    await putAppData();
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
