import 'package:flutter/foundation.dart';

class ServerConfig {
  static String getEnvironment() {
    if (kReleaseMode) {
      // is Release Mode ??
      return "prod";
    }
    return "dev";
  }

  static final String environmentMode = getEnvironment();

  static final String SERVER_HOST = (getEnvironment() == "dev")
      ? 'http://192.168.0.5:'
      : 'http://35.196.197.196:';
  static final String SERVER_PORT =
      (getEnvironment() == "dev") ? '8588' : '8588';
}
