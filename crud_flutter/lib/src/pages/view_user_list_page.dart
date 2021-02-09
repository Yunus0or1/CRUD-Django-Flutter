import 'package:crud_flutter/src/bloc/stream.dart';
import 'package:crud_flutter/src/component/feed/feed_container.dart';
import 'package:crud_flutter/src/models/feed/feed_info.dart';
import 'package:crud_flutter/src/models/general/App_Enum.dart';
import 'package:crud_flutter/src/models/states/event.dart';
import 'package:crud_flutter/src/models/states/ui_state.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Key key = UniqueKey();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    eventChecker();
    UIState.instance.scaffoldKey = scaffoldKey;
  }

  void eventChecker() async {
    Streamer.getEventStream().listen((data) {
      if (data.eventType == EventType.REFRESH_ORDER_PAGE ||
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
