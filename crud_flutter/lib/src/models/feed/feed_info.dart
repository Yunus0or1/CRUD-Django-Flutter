import 'package:crud_flutter/src/models/general/App_Enum.dart';
import 'package:crud_flutter/src/models/general/Enum_Data.dart';

class FeedInfo {
  int userId = 0;
  String feedType = AppEnum.FEED_USER;

  FeedInfo(String feedType) {
    this.feedType = feedType;
  }
}
