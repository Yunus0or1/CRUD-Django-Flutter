import 'package:crud_flutter/src/component/cards/user_list_card.dart';
import 'package:crud_flutter/src/models/feed/feed_info.dart';
import 'package:crud_flutter/src/models/feed/feed_item.dart';
import 'package:crud_flutter/src/models/general/App_Enum.dart';
import 'package:flutter/material.dart';


class FeedCardHandler extends StatelessWidget {
  final FeedInfo feedInfo;
  final FeedItem feedItem;
  final List<FeedItem> feedItems;
  final List<FeedItem> feedItemsPermData;
  final Function callBack;

  const FeedCardHandler(
      {this.feedInfo,
      this.feedItem,
      this.feedItems,
      this.feedItemsPermData,
      this.callBack,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (feedItem.viewCardType == AppEnum.USER_LIST_CARD) {
      return UserListCard(
          user: feedItem.user, key: GlobalKey());
    }

    return Container();
  }
}
