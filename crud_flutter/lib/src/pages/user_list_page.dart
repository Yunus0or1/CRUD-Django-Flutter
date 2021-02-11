import 'package:crud_flutter/src/bloc/stream.dart';
import 'package:crud_flutter/src/component/feed/feed_container.dart';
import 'package:crud_flutter/src/models/feed/feed_info.dart';
import 'package:crud_flutter/src/models/general/App_Enum.dart';
import 'package:crud_flutter/src/models/states/event.dart';
import 'package:crud_flutter/src/models/states/ui_state.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  Key key = UniqueKey();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    eventChecker();
    UIState.instance.scaffoldKey = scaffoldKey;
  }

  void eventChecker() async {
    // This page is listening to stream. If any data changes, stream will be notified,
    // So this page gets refreshed and loads latest data
    Streamer.getEventStream().listen((data) {
      if (data.eventType == EventType.REFRESH_USER_LIST_PAGE ||
          data.eventType == EventType.REFRESH_ALL_PAGES) {
        refreshUI();
      }
    });

  }

  void refreshUI() {
    if (mounted) {
      setState(() {
        key = UniqueKey();
      });
    }
  }

  void refreshTutorialBox() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: Text(
            'USER LIST',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        body: FeedContainer(FeedInfo(AppEnum.FEED_USER), key: key));
  }
}
