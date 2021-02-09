import 'package:firebase_core/firebase_core.dart';
import 'package:pharmacy_app/src/models/states/app_vary_states.dart';
import 'package:pharmacy_app/src/repo/auth_repo.dart';
import 'package:pharmacy_app/src/services/dynamic_link_service.dart';
import 'package:pharmacy_app/src/store/store.dart';
import 'package:pharmacy_app/src/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'src/router.dart';
import 'package:pharmacy_app/src/util/util.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppSate();
  }
}

class _AppSate extends State<App> {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "navigator");

  @override
  void initState() {
    super.initState();
    initProject();
  }

  void initProject() async {
    AppVariableStates.instance.navigatorKey = navigatorKey;
    await Store.initStore();
    await firebaseCloudMessagingListeners();
    await DynamicLinksApi.instance.handleReferralLink();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Aamar Pharma',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Util.colorFromHex("#473FA8"),
        accentColor: Util.colorFromHex("#473FA8"),
      ),
      builder: (context, child) {
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      onGenerateRoute: buildRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
