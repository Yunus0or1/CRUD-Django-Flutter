import 'package:crud_flutter/src/component/general/loading_widget.dart';
import 'package:crud_flutter/src/util/util.dart';
import 'package:flutter/material.dart';
import 'package:crud_flutter/src/models/user/user.dart';

class AddEditUserPage extends StatefulWidget {
  final User user;

  const AddEditUserPage({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new AddEditUserPageState();
}

class AddEditUserPageState extends State<AddEditUserPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final firstNameController = new TextEditingController();
  final lastNameController = new TextEditingController();
  final streetNameController = new TextEditingController();
  final cityNameController = new TextEditingController();
  final stateNameController = new TextEditingController();
  final zipNumberController = new TextEditingController();

  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
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
            'USER FORM',
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

  void submitData() async {}

  String getHintText() {
    return "Airways name, Gate No. Terminal No. etc.";
  }
}
