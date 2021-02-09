import 'package:crud_flutter/src/component/general/app_bar_back_button.dart';
import 'package:crud_flutter/src/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class RequestReceivedSuccessPage extends StatelessWidget {
  final IconData icon;
  final String pageTitle;
  final String title;
  final String message;

  const RequestReceivedSuccessPage(
      {Key key, this.icon, this.title, this.message, this.pageTitle})
      : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: AppBarBackButtonCross(),
          elevation: 1,
          centerTitle: true,
          title: Text(pageTitle,
             style: TextStyle( color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),),
        ),
        body: buildBody());
  }

  Widget buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: 80,
            color: Util.greenishColor(),
          ),
        ),
        SizedBox(height: 30),
        Container(
          child: Text(title,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 17),),
        ),
        Container(
          width: 200,
          alignment: Alignment.center,
          child: Text(message,
              textAlign: TextAlign.center, style: TextStyle(color: Colors.grey),),
        )
      ],
    );
  }
}
