import 'package:crud_flutter/src/bloc/stream.dart';
import 'package:crud_flutter/src/component/buttons/general_action_round_button.dart';
import 'package:crud_flutter/src/component/general/loading_widget.dart';
import 'package:crud_flutter/src/models/general/App_Enum.dart';
import 'package:crud_flutter/src/models/general/Enum_Data.dart';
import 'package:crud_flutter/src/component/general/drop_down_item.dart';
import 'package:crud_flutter/src/models/states/event.dart';
import 'package:crud_flutter/src/models/user/address_details.dart';
import 'package:crud_flutter/src/repo/user_repo.dart';
import 'package:crud_flutter/src/store/store.dart';
import 'package:crud_flutter/src/util/util.dart';
import 'package:flutter/material.dart';
import 'package:crud_flutter/src/models/user/user.dart';
import 'package:tuple/tuple.dart';

class AddEditUserPage extends StatefulWidget {
  final User user;
  final List<User> parentUserList;
  final String addEditMethod;

  const AddEditUserPage(
      {Key key, this.user, this.parentUserList, this.addEditMethod})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new AddEditUserPageState();
}

class AddEditUserPageState extends State<AddEditUserPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController streetNameController;
  TextEditingController cityNameController;
  TextEditingController stateNameController;
  TextEditingController zipNumberController;

  List<String> parentNameList = [];
  String selectedParentForChild;

  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    firstNameController =
        new TextEditingController(text: widget.user.firstName);
    lastNameController = new TextEditingController(text: widget.user.lastName);
    streetNameController =
        new TextEditingController(text: widget.user.address?.street);
    cityNameController =
        new TextEditingController(text: widget.user.address?.city);
    stateNameController =
        new TextEditingController(text: widget.user.address?.state);
    zipNumberController =
        new TextEditingController(text: widget.user.address?.zip);

    if (widget.parentUserList != null) {
      parentNameList.add('SELECT A PARENT');
      // Appending Name And First 8 character of the ID, so no duplicate value should be in dropdown
      widget.parentUserList.forEach((singleParent) {
        parentNameList.add(singleParent.firstName +
            ' (' +
            singleParent.userId.split('_')[1] +
            ')');
      });
      selectedParentForChild = parentNameList[0];
      if (widget.user.childDependentId != null) {
        // So it means the child user is in edit system. so loading his actualy Parent name
        final String parentFirstName = widget.parentUserList
            .firstWhere(
                (element) => element.userId == widget.user.childDependentId)
            .firstName;
        final String childDependentSubId = widget.parentUserList
            .firstWhere(
                (element) => element.userId == widget.user.childDependentId)
            .userId
            .split('_')[1];// Split because the long ID contains _ So based on the split the first portion is taken

        selectedParentForChild =
            parentFirstName + ' (' + childDependentSubId + ')';
      }
    }
  }

  void refreshUI() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Util.removeFocusNode(context),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: Text(
            'USER (${widget.user.userType}) FORM',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        key: _scaffoldKey,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(20, 5, 20, 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    buildBody(),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget buildBody() {
    return isProcessing ? buildVerificationLoadingWidget() : buildBox();
  }

  Widget buildVerificationLoadingWidget() {
    return Column(
      children: <Widget>[
        LoadingWidget(status: 'Submitting User data..'),
      ],
    );
  }

  Widget buildBox() {
    final children = List<Widget>();

    children.add(buildFormWidget(
        textTitle: 'FIRST NAME',
        hintText: 'Mr. XYZ',
        textEditingController: firstNameController));

    children.add(buildFormWidget(
        textTitle: 'LAST NAME',
        hintText: 'Mr. XYZ',
        textEditingController: lastNameController));

    if (widget.user.userType == AppEnum.USER_TYPE_PARENT) {
      children.add(buildFormWidget(
          textTitle: 'STREET NAME',
          hintText: 'Road 1',
          textEditingController: streetNameController));

      children.add(buildFormWidget(
          textTitle: 'CITY NAME',
          hintText: 'Sylhet',
          textEditingController: cityNameController));

      children.add(buildFormWidget(
          textTitle: 'STATE NAME',
          hintText: 'New York City',
          textEditingController: stateNameController));

      children.add(buildFormWidget(
          textTitle: 'ZIP NUMBER',
          hintText: '3138',
          textEditingController: zipNumberController));
    }

    if (widget.user.userType == AppEnum.USER_TYPE_CHILD) {
      children.add(buildParentDropDownMenu());
    }

    children.add(
      GeneralActionRoundButton(
        title: "Submit",
        textColor: Colors.white,
        isProcessing: isProcessing,
        callBackOnSubmit: submitData,
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: children,
      ),
    );
  }

  Widget buildFormWidget({
    String textTitle,
    String hintText,
    TextEditingController textEditingController,
  }) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            textTitle,
            style: TextStyle(
                color: Util.purplishColor(), fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 3),
          SizedBox(
            height: 35, // set this
            child: TextField(
              controller: textEditingController,
              decoration: new InputDecoration(
                isDense: true,
                hintText: hintText,
                hintStyle: TextStyle(fontSize: 13),
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildParentDropDownMenu() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'PARENT',
            style: TextStyle(
                color: Util.purplishColor(), fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 3),
          DropDownItem(
            dropDownList: parentNameList,
            selectedItem: selectedParentForChild,
            setSelectedItem: setParentForChild,
            callBackRefreshUI: refreshUI,
            dropDownTextColor: Colors.black,
            dropDownContainerColor: Colors.white,
          )
        ],
      ),
    );
  }

  void setParentForChild(dynamic value) {
    selectedParentForChild = value;
  }

  void submitData() async {
    if (firstNameController.text.isEmpty || lastNameController.text.isEmpty) {
      Util.showSnackBar(
          scaffoldKey: _scaffoldKey,
          message: "All fields are mandatory",
          duration: 1500);
      return;
    }

    if (widget.user.userType == AppEnum.USER_TYPE_PARENT) {
      if (streetNameController.text.isEmpty ||
          cityNameController.text.isEmpty ||
          stateNameController.text.isEmpty ||
          zipNumberController.text.isEmpty) {
        Util.showSnackBar(
            scaffoldKey: _scaffoldKey,
            message: "All fields are mandatory",
            duration: 1500);
        return;
      }
    }
    if (widget.user.userType == AppEnum.USER_TYPE_CHILD) {
      if (selectedParentForChild == 'SELECT A PARENT') {
        Util.showSnackBar(
            scaffoldKey: _scaffoldKey,
            message: "Select a parent for the child",
            duration: 1500);
        return;
      }
    }

    if (firstNameController.text == 'SELECT A PARENT') {
      Util.showSnackBar(
          scaffoldKey: _scaffoldKey,
          message: "Please add a proper first name",
          duration: 1500);
      return;
    }

    isProcessing = true;
    refreshUI();

    AddressDetails addressDetails;
    String childDependentId;
    if (widget.user.userType == AppEnum.USER_TYPE_CHILD) {
      addressDetails = null;
      // Setting childDependentId of Parent
      final start = '(';
      final end = ')';

      final startIndex = selectedParentForChild.indexOf(start);
      final endIndex = selectedParentForChild.indexOf(end);
      final childDependentSubId = selectedParentForChild
          .substring(startIndex + start.length, endIndex)
          .trim();

      childDependentId = widget.parentUserList
          .firstWhere((element) => element.userId.contains(childDependentSubId))
          .userId;
    } else if (widget.user.userType == AppEnum.USER_TYPE_PARENT) {
      {
        addressDetails = AddressDetails()
          ..street = streetNameController.text
          ..city = cityNameController.text
          ..state = stateNameController.text
          ..zip = zipNumberController.text;
        childDependentId = null;
      }
    }

    User user = new User()
      ..insertByUserId = Store.instance.appState.userUUID
      ..firstName = firstNameController.text
      ..lastName = lastNameController.text
      ..childDependentId = childDependentId
      ..address = addressDetails
      ..userType = widget.user.userType;

    if (widget.addEditMethod == AppEnum.METHOD_UPDATE) {
      user.userId = widget.user.userId;
    }

    Tuple2<void, String> addEditUserResponse = await UserRepo.instance
        .addEditUser(user: user, addEditMethod: widget.addEditMethod);

    final responseCode = addEditUserResponse.item2;

    if (responseCode == ClientEnum.RESPONSE_SUCCESS) {
      if (widget.addEditMethod == AppEnum.METHOD_INSERT) {
        Util.showSnackBar(
            scaffoldKey: _scaffoldKey, message: "Added User successfully");
      } else if (widget.addEditMethod == AppEnum.METHOD_UPDATE) {
        Util.showSnackBar(
            scaffoldKey: _scaffoldKey, message: "Updated User successfully");
      }

      await Future.delayed(Duration(seconds: 2));
      // After add or edit refreshing the User list page to get latest data
      Streamer.putEventStream(Event(EventType.REFRESH_USER_LIST_PAGE));
      Navigator.of(context).pop();
    } else {
      Util.showSnackBar(
          scaffoldKey: _scaffoldKey,
          message: "Something went wrong. Please try again.");
    }
    isProcessing = false;
    refreshUI();
  }

}
