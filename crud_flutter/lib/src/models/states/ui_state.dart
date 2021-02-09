import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UIState {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  static UIState _uiState;
  static UIState get instance => _uiState ??= UIState();
}
