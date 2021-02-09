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

  static final String SERVER_HOST = 'http://pharmacy.arbreesolutions.com:';
  static final String SERVER_PORT = "80";
}
