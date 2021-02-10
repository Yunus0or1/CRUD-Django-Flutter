import 'package:crud_flutter/router.dart';
import 'package:crud_flutter/src/store/store.dart';
import 'package:crud_flutter/src/util/util.dart';
import 'package:flutter/material.dart';

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
    await Store.initStore();
    Store.instance.createUserUUID();
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
