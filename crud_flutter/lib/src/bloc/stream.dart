import 'dart:async';
import 'package:pharmacy_app/src/models/states/event.dart';

class Streamer {
  static StreamController<Event> _streamControllerEvent =
      new StreamController.broadcast();
  static StreamController<String> _streamControllerError =
      new StreamController.broadcast();

  static StreamController<int> _streamControllerTotalOrder =
      new StreamController.broadcast();
  static StreamController<int> _streamControllerNotificationCount =
      new StreamController.broadcast();

  static Stream<Event> getEventStream() {
    return _streamControllerEvent.stream;
  }

  static void putEventStream(Event event) {
    _streamControllerEvent.sink.add(event);
  }

  static Stream<String> getErrorStream() {
    return _streamControllerError.stream;
  }

  static void putErrorStream(String streamData) {
    _streamControllerError.sink.add(streamData);
  }

  static Stream<int> getTotalOrderStream() {
    return _streamControllerTotalOrder.stream;
  }

  static void putTotalOrderStream(int totalOrder) {
    _streamControllerTotalOrder.sink.add(totalOrder);
  }

  static Stream<int> getTotalNotificationCountStream() {
    return _streamControllerNotificationCount.stream;
  }

  static void putTotalNotificationCountStream(int notificationNumber) {
    _streamControllerNotificationCount.sink.add(notificationNumber);
  }
}
