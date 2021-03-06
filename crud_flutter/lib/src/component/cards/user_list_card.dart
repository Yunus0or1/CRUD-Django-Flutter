import 'package:crud_flutter/src/bloc/stream.dart';
import 'package:crud_flutter/src/component/general/common_ui.dart';
import 'package:crud_flutter/src/models/general/App_Enum.dart';
import 'package:crud_flutter/src/models/general/Enum_Data.dart';
import 'package:crud_flutter/src/models/states/event.dart';
import 'package:crud_flutter/src/models/states/ui_state.dart';
import 'package:crud_flutter/src/models/user/user.dart';
import 'package:crud_flutter/src/pages/add_edit_user_page.dart';
import 'package:crud_flutter/src/repo/user_repo.dart';
import 'package:crud_flutter/src/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

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
              onTap: () async {
                if (user.userType == AppEnum.USER_TYPE_PARENT)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddEditUserPage(
                              user: user,
                              addEditMethod: AppEnum.METHOD_UPDATE,
                            )),
                  );

                if (user.userType == AppEnum.USER_TYPE_CHILD) {
                  Util.showSnackBar(
                      scaffoldKey: UIState.instance.scaffoldKey,
                      message: "Please wait",
                      duration: 1000);
                  Tuple2<List<User>, String> parentListResponse =
                      await UserRepo.instance.getParentList();

                  final List<User> parentUserList = parentListResponse.item1;
                  final responseCode = parentListResponse.item2;

                  if (responseCode == ClientEnum.RESPONSE_SUCCESS) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddEditUserPage(
                                user: user,
                                addEditMethod: AppEnum.METHOD_UPDATE,
                                parentUserList: parentUserList,
                              )),
                    );
                  } else {
                    Util.showSnackBar(
                        scaffoldKey: UIState.instance.scaffoldKey,
                        message: "Something went wrong. Please try again.");
                  }
                }
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
                    height: 180,
                    message: (user.userType == AppEnum.USER_TYPE_PARENT)
                        ? "Are you sure to remove this Parent? All children of this parent will be removed automatically."
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

  void deleteUser() async {
    Tuple2<void, String> deleteUserResponse =
        await UserRepo.instance.deleteUser(userId: user.userId);

    final responseCode = deleteUserResponse.item2;

    if (responseCode == ClientEnum.RESPONSE_SUCCESS) {
      Util.showSnackBar(
          scaffoldKey: UIState.instance.scaffoldKey,
          message: "Removed User successfully");
      Streamer.putEventStream(Event(EventType.REFRESH_USER_LIST_PAGE));
    } else {
      Util.showSnackBar(
          scaffoldKey: UIState.instance.scaffoldKey,
          message: "Something went wrong. Please try again.");
    }
  }
}
