import 'dart:typed_data';
import 'package:crud_flutter/src/bloc/stream.dart';
import 'package:crud_flutter/src/models/general/App_Enum.dart';
import 'package:crud_flutter/src/models/states/event.dart';
import 'package:crud_flutter/src/pages/add_edit_user_page.dart';
import 'package:crud_flutter/src/pages/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:crud_flutter/src/component/buttons/general_action_round_button.dart';
import 'package:crud_flutter/src/models/user/user.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    eventChecker();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void eventChecker() async {
    Streamer.getEventStream().listen((data) {
      if (data.eventType == EventType.REFRESH_HOME_PAGE ||
          data.eventType == EventType.REFRESH_ALL_PAGES) {
        refreshUI();
      }

      if (data.eventType == EventType.CHANGE_LANGUAGE) {
        refreshUI();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: Text(
            'HOME',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        body: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GeneralActionRoundButton(
              title: "Add Parent User",
              textColor: Colors.white,
              isProcessing: false,
              callBackOnSubmit: navigateToAddEditParentUser,
            ),
            GeneralActionRoundButton(
              title: "Add Child User",
              textColor: Colors.white,
              isProcessing: false,
              callBackOnSubmit: navigateToAddEditChildUser,
            ),
            GeneralActionRoundButton(
              title: "View User List",
              textColor: Colors.white,
              isProcessing: false,
              callBackOnSubmit: navigateToUserListPage,
            )
          ],
        ),
      ),
    );
  }

  navigateToAddEditParentUser() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddEditUserPage(
                user: User()..userType = AppEnum.USER_TYPE_PARENT,
                userAdd: true,
              )),
    );
  }

  navigateToAddEditChildUser() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddEditUserPage(
                user: User()..userType = AppEnum.USER_TYPE_CHILD,
                userAdd: true,
              )),
    );
  }

  navigateToUserListPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserListPage()),
    );
  }

  void refreshUI() {
    if (mounted) setState(() {});
  }
}
