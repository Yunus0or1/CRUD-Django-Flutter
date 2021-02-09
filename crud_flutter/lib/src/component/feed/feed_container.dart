import 'dart:async';
import 'package:crud_flutter/src/bloc/stream.dart';
import 'package:crud_flutter/src/component/general/common_ui.dart';
import 'package:crud_flutter/src/models/feed/feed_info.dart';
import 'package:crud_flutter/src/models/feed/feed_item.dart';
import 'package:crud_flutter/src/models/feed/feed_request.dart';
import 'package:crud_flutter/src/models/feed/feed_response.dart';
import 'package:crud_flutter/src/models/general/Enum_Data.dart';
import 'package:crud_flutter/src/models/states/event.dart';
import 'package:crud_flutter/src/models/states/ui_state.dart';
import 'package:crud_flutter/src/repo/user_repo.dart';
import 'package:crud_flutter/src/util/util.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'feed_card_handler.dart';

class FeedContainer extends StatefulWidget {
  final FeedInfo feedInfo;

  const FeedContainer(this.feedInfo, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FeedContainerState(feedInfo);
  }
}

class _FeedContainerState extends State<FeedContainer>
    with AutomaticKeepAliveClientMixin<FeedContainer> {
  final FeedInfo feedInfo;
  List<FeedItem> feedItems;
  List<FeedItem> feedItemsPermData;
  FeedResponse feedResponse = new FeedResponse();
  bool isProcessing = true;
  bool noItem = false;
  bool noInternet = false;
  bool noServer = false;

  _FeedContainerState(this.feedInfo);

  @override
  void initState() {
    super.initState();
    feedItems = new List();
    feedItemsPermData = new List();
    clearItems();
    refreshFeed();
    eventChecker();
  }

  void eventChecker() async {
    Streamer.getEventStream().listen((data) {
      if (data.eventType == EventType.REFRESH_FEED_CONTAINER ||
          data.eventType == EventType.REFRESH_ALL_PAGES) {
        feedItems.clear();
        refreshFeed();
      }
    });
  }

  void refreshUI() {
    if (mounted)
      setState(() {
        refreshFeed();
      });
  }

  void refreshSearchItems() {
    if (mounted) setState(() {});
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  Future<void> refreshFeed() async {
    isProcessing = true;
    noInternet = false;
    noServer = false;
    noItem = false;

    clearItems();
    FeedRequest feedRequest = new FeedRequest(widget.feedInfo, 0, '');
    requestLoadFeed(feedRequest);
  }

  void clearItems() {
    if (mounted)
      setState(() {
        feedItemsPermData.clear();
        feedItems.clear();
      });
  }

  Future<void> requestLoadFeed(FeedRequest feedRequest) async {
    FeedResponse feedResponse = new FeedResponse();
    String responseCode;

    Tuple2<FeedResponse, String> response =
        await UserRepo.instance.getFeed(feedRequest);
    responseCode = response.item2;

    if (responseCode == ClientEnum.RESPONSE_SUCCESS) {
      feedResponse = response.item1;
      if (feedResponse.status) {
        addItems(feedResponse.feedItems, feedRequest);
      }
    } else if (responseCode == ClientEnum.RESPONSE_CONNECTION_ERROR) {
      Util.showSnackBar(
          scaffoldKey: UIState.instance.scaffoldKey,
          message: "Something went wrong. Please try again");
    }
    if (feedResponse.feedItems == null || feedResponse.feedItems.isEmpty) {
      noItem = true;
    }

    isProcessing = false;

    if (mounted) setState(() {});
  }

  void addItems(List<FeedItem> items, FeedRequest feedRequest) {
    feedItems.addAll(items);

    feedItemsPermData = feedItems.sublist(0, feedItems.length);

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (noInternet == true) {
      return noInternetView(refreshFeed);
    }
    if (isProcessing == true) {
      return loadingSpinnerView(refreshFeed);
    }
    if (noItem == true) {
      return noItemView(refreshFeed);
    }
    if (noServer == true) {
      return noServerView(refreshFeed);
    }
    return buildFeedView();
  }

  Widget buildFeedView() {
    return RefreshIndicator(
      onRefresh: refreshFeed,
      backgroundColor: new Color.fromARGB(255, 4, 72, 71),
      color: Colors.white,
      child: GestureDetector(
        onTap: () => Util.removeFocusNode(context),
        child: Container(
          color: Colors.grey[50],
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: feedItems.length,
            itemBuilder: (context, int index) {
              return index >= feedItems.length
                  ? Container()
                  : buildFeedCard(feedItems[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget buildFeedCard(FeedItem item) {
    return FeedCardHandler(
      feedInfo: feedInfo,
      feedItem: item,
      feedItems: feedItems,
      feedItemsPermData: feedItemsPermData,
      callBack: refreshSearchItems,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
