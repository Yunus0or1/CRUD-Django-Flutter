import 'package:flutter/material.dart';
import 'package:pharmacy_app/src/component/cards/notification_card.dart';
import 'package:pharmacy_app/src/component/cards/repeat_order_card.dart';
import 'package:pharmacy_app/src/component/cards/request_order_card.dart';
import 'package:pharmacy_app/src/component/cards/request_order_page_button_card.dart';
import 'package:pharmacy_app/src/models/feed/feed_info.dart';
import 'package:pharmacy_app/src/models/feed/feed_item.dart';
import 'package:pharmacy_app/src/models/general/Enum_Data.dart';
import 'package:pharmacy_app/src/component/cards/order_card.dart';
import 'package:pharmacy_app/src/component/cards/drop_down_filter_card.dart';
import 'package:pharmacy_app/src/models/general/Order_Enum.dart';

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
    if (feedItem.viewCardType == OrderEnum.FEED_ITEM_ORDER_FILTER_CARD)
      return DropDownFilterCard(
        feedItems: feedItems,
        feedItemsPermData: feedItemsPermData,
        callBack: callBack,
      );

    if (feedItem.viewCardType ==
        OrderEnum.FEED_ITEM_REQUEST_ORDER_PAGE_BUTTON_CARD) {
      return RequestOrderPageButtonCard(key: GlobalKey());
    }
    if (feedItem.viewCardType == OrderEnum.FEED_ITEM_REQUEST_ORDER_CARD) {
      return RequestOrderCard(
          requestOrder: feedItem.requestOrder, key: GlobalKey());
    }
    if (feedItem.viewCardType == OrderEnum.FEED_ITEM_ORDER_CARD) {
      return OrderCard(order: feedItem.order, key: GlobalKey());
    }
    if (feedItem.viewCardType == OrderEnum.FEED_ITEM_REPEAT_ORDER_CARD) {
      return RepeatOrderCard(order: feedItem.order, key: GlobalKey());
    }
    if (feedItem.viewCardType == OrderEnum.FEED_ITEM_NOTIFICATION_CARD) {
      return NotificationCard(
          notificationItem: feedItem.notificationItem, key: GlobalKey());
    }

    return Container();
  }
}
