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
  REFRESH_FEED_CONTAINER,
  REFRESH_USER_LIST_PAGE
}
