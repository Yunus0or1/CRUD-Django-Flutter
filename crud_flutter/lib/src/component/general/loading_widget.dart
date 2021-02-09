import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String status;
  final bool displayRetry;
  final Function() retryAction;

  LoadingWidget({
    this.status,
    this.displayRetry = false,
    this.retryAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: buildChildren(context),
        ),
      ),
    );
  }

  List<Widget> buildChildren(BuildContext context) {
    // Build children list
    final children = <Widget>[];
    // add retry or progressbar
    if (displayRetry) {
      children.add(buildRetryButton(context));
    } else {
      children.add(CircularProgressIndicator(
        backgroundColor: Colors.black,
      ));
    }
    // add status
    children.add(
      Text(
        status,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey),
      ),
    );
    // Add padding to all children
    return children.map((child) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: child,
      );
    }).toList();
  }

  Widget buildRetryButton(BuildContext context) {
    return OutlineButton(
      child: Text('Refresh'),
      onPressed: () => onRetryButtonPress(context),
      color: Colors.black,
      textColor: Colors.black,
      highlightColor: Colors.black,
      borderSide:
          BorderSide(color: Colors.black, style: BorderStyle.solid, width: 2.0),
    );
  }

  void onRetryButtonPress(BuildContext context) {
    if (retryAction != null) {
      retryAction();
    }
  }
}
