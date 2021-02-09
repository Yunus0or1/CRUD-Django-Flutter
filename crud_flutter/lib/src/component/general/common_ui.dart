import 'package:flutter/material.dart';
import 'package:pharmacy_app/src/util/en_bn_dict.dart';

Widget commonDivider({double height}) {
  return Container(
    width: double.infinity,
    height: height ?? 10,
    color: Colors.grey[100],
  );
}

Widget CustomText(String title,
    {double fontSize,
    TextOverflow overflow,
    FontWeight fontWeight,
    Color color,
    TextAlign textAlign}) {
  return Text(
    EnBnDict.en_bn_convert(text: title),
    overflow: overflow ?? TextOverflow.fade,
    textAlign: textAlign ?? TextAlign.center,
    style: TextStyle(
        fontFamily: EnBnDict.en_bn_font(),
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize ?? 14.5,
        color: color ?? Colors.black),
  );
}

Widget noItemView(dynamic refreshCallback) {
  return RefreshIndicator(
    backgroundColor: Colors.black,
    onRefresh: refreshCallback,
    child: ListView.builder(
      padding: EdgeInsets.fromLTRB(2.0, 5.0, 2.0, 5.0),
      itemCount: 1,
      itemBuilder: (context, int index) {
        return index >= 1
            ? Container()
            : Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Padding(padding: EdgeInsets.symmetric(vertical: 100.0)),
                    Text("Empty List",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center),
                    SizedBox(height: 10),
                  ],
                ),
              );
      },
    ),
  );
}

Widget noInternetView(dynamic refreshCallback) {
  return Container(
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          'assets/images/happy_internet.png',
          alignment: Alignment.center,
          fit: BoxFit.contain,
          // width: 128.0,
          height: 100.0,
        ),
        SizedBox(height: 10),
        Text("No active internet connection"),
        SizedBox(height: 10),
        MaterialButton(
          child: new Text('Retry',
              style: new TextStyle(fontSize: 16.0, color: Colors.blue)),
          onPressed: refreshCallback,
        ),
      ],
    ),
  );
}

Widget loadingSpinnerView(dynamic refreshCallback) {
  return Container(
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 10),
        Column(
          children: <Widget>[
            SizedBox(height: 20),
            SizedBox(
                height: 30.0,
                width: 30.0,
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                    strokeWidth: 4.0)),
            SizedBox(height: 20)
          ],
        ),
        SizedBox(height: 10),
      ],
    ),
  );
}

Widget noServerView(dynamic refreshCallback) {
  return Container(
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          'assets/images/happy_internet.png',
          alignment: Alignment.center,
          fit: BoxFit.contain,
          // width: 128.0,
          height: 100.0,
        ),
        SizedBox(height: 10),
        Text("Something went wrong. Please try again."),
        SizedBox(height: 10),
        MaterialButton(
          child: new Text('Retry',
              style: new TextStyle(fontSize: 16.0, color: Colors.blue)),
          onPressed: refreshCallback,
        ),
      ],
    ),
  );
}

Widget CustomTextWidget(String textData, {bool bold, int maxLines}) {
  return Expanded(
    child: Text(
      textData,
      style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
          fontWeight: (bold == true) ? FontWeight.bold : FontWeight.normal),
      maxLines: maxLines ?? 1,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

void showAlertDialog(
    {BuildContext context,
    String message,
    Function acceptFunc,
    double height}) {
  showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)), //this right here
          child: Container(
            height: height ?? 130,
            width: 50,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("ARE YOU SURE ?",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Divider(height: 1, color: Colors.grey[700]),
                  SizedBox(height: 15),
                  Text(message,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(dialogContext);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          width: 60,
                          height: 30,
                          child: Text(
                            "NO",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(width: 50),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(dialogContext);
                          acceptFunc();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          width: 60,
                          height: 30,
                          child: Text(
                            "YES",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

void showAlertDialogCancelReport(
    {BuildContext context,
    String message,
    TextEditingController textEditingController,
    Function acceptFunc}) {
  showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)), //this right here
          child: Container(
            height: 300,
            width: 50,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("ARE YOU SURE ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Divider(height: 1, color: Colors.grey[700]),
                  SizedBox(height: 15),
                  Text(message,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  SizedBox(height: 20),
                  Column(
                    children: <Widget>[
                      TextFormField(
                        controller: textEditingController,
                        maxLines: 5,
                        onSaved: (text) {
                          textEditingController.text = text;
                        },
                        decoration: new InputDecoration(
                          labelText: "Please specify the reason (Optional)",
                          labelStyle: TextStyle(fontSize: 12),
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(dialogContext);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          width: 60,
                          height: 30,
                          child: Text(
                            "NO",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(width: 50),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(dialogContext);

                          acceptFunc(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          width: 60,
                          height: 30,
                          child: Text(
                            "YES",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
