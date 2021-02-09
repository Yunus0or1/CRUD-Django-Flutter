import 'package:crud_flutter/src/component/general/common_ui.dart';
import 'package:crud_flutter/src/models/general/App_Enum.dart';
import 'package:crud_flutter/src/models/user/user.dart';
import 'package:crud_flutter/src/pages/add_edit_user_page.dart';
import 'package:crud_flutter/src/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserListCard extends StatelessWidget {
  final User user;
  UserListCard({this.user, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Util.removeFocusNode(context),
      child: Container(
        padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
        width: double.infinity,
        child: Material(
          shadowColor: Colors.grey[100].withOpacity(0.4),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5,
          clipBehavior: Clip.antiAlias, // Add This
          child: buildBody(context),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildTitle(context),
      ],
    );
  }

  Widget buildTitle(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 90,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddEditUserPage(
                            user: user,
                            userAdd: false,
                          )),
                );
              },
              child: Container(
                width: 30,
                child: Icon(
                  Icons.edit,
                  color: Util.greenishColor(),
                  size: 28,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.firstName,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text(user.firstName,
                      style:
                          TextStyle(color: new Color.fromARGB(255, 4, 72, 71)))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showAlertDialog(
                    context: context,
                    height: 150,
                    message: (user.userType == AppEnum.USER_TYPE_PARENT)
                        ? "Are you sure to remove this Parent? All children will be removed automatically."
                        : "Are you sure to remove this child?",
                    acceptFunc: deleteUser);
              },
              child: Container(
                width: 30,
                child: Icon(Icons.delete, size: 28.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  void deleteUser() {}
}
