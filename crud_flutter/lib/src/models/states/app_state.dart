import 'package:pharmacy_app/src/models/order/deliver_address_details.dart';
import 'package:pharmacy_app/src/models/user/user.dart';
import 'package:pharmacy_app/src/models/general/Enum_Data.dart';

class AppState {
  String language = ClientEnum.LANGUAGE_ENGLISH;
  User user = new User();
  List<DeliveryAddressDetails> allDeliveryAddress =
      new List<DeliveryAddressDetails>();
  String firebasePushNotificationToken = "";
  String referralCode = "";
  int initialTutorialScrollingPage = 0;
  int tutorialBoxNumberHomePage = 0;
  int tutorialBoxNumberAddItemsPage = 0;
  int tutorialBoxNumberUploadPrescriptionVerifyPage = 0;
  int tutorialBoxNumberConfirmOrderPage = 0;
  int tutorialBoxNumberConfirmInvoicePage = 0;
  int tutorialBoxNumberOrderPage = 0;
  int tutorialBoxNumberRepeatOrderPage = 0;
  int tutorialBoxNumberOrderFinalInvoicePage = 0;
  int tutorialBoxNumberRequestOrderPage = 0;

  AppState() {}

  AppState.fromJsonMap(Map<String, dynamic> data) {
    language = data['LANGUAGE'];
    user = User.fromJson(data['USER']);
    allDeliveryAddress = (data['DELIVERY_ADDRESS_LIST'] == [])
        ? []
        : data['DELIVERY_ADDRESS_LIST']
            .map((singleDeliveryAddress) =>
                DeliveryAddressDetails.fromJson(singleDeliveryAddress))
            .toList()
            .cast<DeliveryAddressDetails>();
    firebasePushNotificationToken = data['FIREBASE_PUSH_NOTIFICATION_TOKEN'];
    referralCode = data['REFERRAL_CODE'];
    initialTutorialScrollingPage = data['INITIAL_TUTORIAL_SCROLLING_PAGE'];
    tutorialBoxNumberHomePage = data['TUTORIAL_BOX_NUMBER_HOME_PAGE'] ?? 0;
    tutorialBoxNumberAddItemsPage =
        data['TUTORIAL_BOX_NUMBER_ADD_ITEMS_PAGE'] ?? 0;
    tutorialBoxNumberUploadPrescriptionVerifyPage =
        data['TUTORIAL_BOX_NUMBER_UPLOAD_PRESCRIPTION_VERIFY_PAGE'] ?? 0;
    tutorialBoxNumberConfirmOrderPage =
        data['TUTORIAL_BOX_NUMBER_CONFIRM_ORDER_PAGE'] ?? 0;
    tutorialBoxNumberConfirmInvoicePage =
        data['TUTORIAL_BOX_NUMBER_CONFIRM_INVOICE_PAGE'] ?? 0;
    tutorialBoxNumberOrderPage = data['TUTORIAL_BOX_NUMBER_ORDER_PAGE'] ?? 0;
    tutorialBoxNumberRepeatOrderPage =
        data['TUTORIAL_BOX_NUMBER_REPEAT_ORDER_PAGE'] ?? 0;
    tutorialBoxNumberOrderFinalInvoicePage =
        data['TUTORIAL_BOX_NUMBER_ORDER_FINAL_INVOICE_PAGE'] ?? 0;
    tutorialBoxNumberRequestOrderPage =
        data['TUTORIAL_BOX_NUMBER_REQUEST_ORDER_PAGE'] ?? 0;
  }

  Map<String, dynamic> toJsonMap() {
    final data = Map<String, dynamic>();
    data['LANGUAGE'] = language;
    data['USER'] = user.toJsonMap();
    data['DELIVERY_ADDRESS_LIST'] = (allDeliveryAddress == null ||
            allDeliveryAddress.isEmpty)
        ? []
        : allDeliveryAddress
            .map((singleDeliveryAddress) => singleDeliveryAddress.toJsonMap())
            .toList();
    data['FIREBASE_PUSH_NOTIFICATION_TOKEN'] = firebasePushNotificationToken;
    data['REFERRAL_CODE'] = referralCode;
    data['INITIAL_TUTORIAL_SCROLLING_PAGE'] = initialTutorialScrollingPage;
    data['TUTORIAL_BOX_NUMBER_HOME_PAGE'] = tutorialBoxNumberHomePage;
    data['TUTORIAL_BOX_NUMBER_ADD_ITEMS_PAGE'] = tutorialBoxNumberAddItemsPage;
    data['TUTORIAL_BOX_NUMBER_UPLOAD_PRESCRIPTION_VERIFY_PAGE'] =
        tutorialBoxNumberUploadPrescriptionVerifyPage;
    data['TUTORIAL_BOX_NUMBER_CONFIRM_ORDER_PAGE'] =
        tutorialBoxNumberConfirmOrderPage;
    data['TUTORIAL_BOX_NUMBER_CONFIRM_INVOICE_PAGE'] =
        tutorialBoxNumberConfirmInvoicePage;
    data['TUTORIAL_BOX_NUMBER_ORDER_PAGE'] = tutorialBoxNumberOrderPage;
    data['TUTORIAL_BOX_NUMBER_REPEAT_ORDER_PAGE'] =
        tutorialBoxNumberRepeatOrderPage;
    data['TUTORIAL_BOX_NUMBER_ORDER_FINAL_INVOICE_PAGE'] =
        tutorialBoxNumberOrderFinalInvoicePage;
    data['TUTORIAL_BOX_NUMBER_REQUEST_ORDER_PAGE'] =
        tutorialBoxNumberRequestOrderPage;

    return data;
  }
}
