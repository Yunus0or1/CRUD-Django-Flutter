class Event {
  EventType _eventType;
  int _id;

  Event(EventType eventType) {
    _eventType = eventType;
  }

  EventType get eventType => _eventType;

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}

enum EventType {
  REFRESH_ALL_PAGES,
  REFRESH_MAIN_PAGE,
  REFRESH_HOME_PAGE,
  REFRESH_UPLOAD_PRESCRIPTION_VERIFY_PAGE,
  REFRESH_CONFIRM_ORDER_PAGE,
  REFRESH_USER_DETAILS_PAGE,
  REFRESH_ORDER_PAGE,
  REFRESH_REPEAT_ORDER_PAGE,
  REFRESH_REQUEST_ORDER_PAGE,
  REFRESH_VERIFICATION_PAGE,
  REFRESH_LOGIN_PAGE,
  REFRESH_PRINT_RECEIPT_PAGE,
  REFRESH_FEED_CONTAINER,
  SWITCH_TO_ORDER_NAVIGATION_PAGE,
  CHANGE_LANGUAGE,
}
