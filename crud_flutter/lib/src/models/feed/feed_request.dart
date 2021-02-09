import 'package:crud_flutter/src/models/feed/feed_info.dart';

class FeedRequest {
  FeedInfo feedInfo;
  int nextFromId = 0;
  String session = "";
  int feedSize = 15;

  FeedRequest(this.feedInfo, this.nextFromId, this.session);

  Map<String, dynamic> toJsonMapString() {
    final data = Map<String, dynamic>();
    data['FEED_INFO'] = feedInfo;
    data['NEXT_FROM_ID'] = nextFromId;
    data['SESSION'] = session;
    data['FEED_SIZE'] = feedSize;
    return data;
  }
}
