import 'package:crud_flutter/src/util/util.dart';
import 'package:flutter/material.dart';

class GeneralActionRoundButton extends StatelessWidget {
  final bool isProcessing;
  final void Function() callBackOnSubmit;
  final String title;
  final EdgeInsetsGeometry padding;
  final double height;
  final Color color;
  final Color textColor;

  GeneralActionRoundButton(
      {this.isProcessing,
      this.callBackOnSubmit,
      this.height,
      this.title,
      this.color,
      this.padding,
      Key key,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.fromLTRB(25, 5, 25, 5),
      alignment: Alignment.center,
      child: MaterialButton(
        height: height ?? 40,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        minWidth: double.infinity,
        onPressed: () => (isProcessing == false) ? callBackOnSubmit() : () {},
        child: Text(
          title,
        ),
        color: getButtonColor(),
      ),
    );
  }

  Color getButtonColor() {
    if (isProcessing == false) {
      if (color == null) {
        return Util.purplishColor();
      } else {
        return color;
      }
    }
    return Colors.grey;
  }
}
