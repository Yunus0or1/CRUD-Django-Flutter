import 'package:crud_flutter/src/models/feed/feed_item.dart';

class FeedResponse {
  bool status;
  bool lastFeed;
  String response;
  int nextFromId;
  String session;
  String feedType;
  List<FeedItem> feedItems;
  bool error;

  FeedResponse(
      {this.status,
      this.lastFeed,
      this.nextFromId,
      this.session,
      this.feedType,
      this.response,
      this.feedItems,
      this.error});
}
