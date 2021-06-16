import 'package:flutter/material.dart';
import 'package:iconnections_challenge/services/data_get.dart';
import 'package:iconnections_challenge/utilities/constants.dart';
import 'package:iconnections_challenge/components/button.dart';
import 'package:iconnections_challenge/screens/token_screen.dart';

class AuthOption extends StatefulWidget {
  AuthOption({required this.email, required this.contactGUID});

  final String email;
  final String contactGUID;

  @override
  _AuthOptionState createState() =>
      _AuthOptionState(email: email, contactGUID: contactGUID);
}

class _AuthOptionState extends State<AuthOption> {
  _AuthOptionState({required this.email, required this.contactGUID});

  AuthOptionsGetter authOptionsGetter = AuthOptionsGetter();
  AuthSelectGetter authSelectGetter = AuthSelectGetter();
  final String email;
  var contactGUID;
  var contactGuid;
  var authOptionId;
  bool isLoading = false;
  bool isVisible = false;
  List data = [];

  @override
  void initState() {
    super.initState();
    asyncMethod();
  }

  void asyncMethod() async {
    setState(() {
      isLoading = true;
    });
    var authID = await authOptionsGetter.postData(email);
    setState(() {
      isLoading = false;
      isVisible = true;
    });
    data = authID['authenticationOptions'];
  }

  void updateUI(dynamic dataData) {
    setState(() {
      if (dataData == null) {
        contactGuid = '';
        return;
      }
      contactGuid = dataData['contactGuid'];
    });
  }

  List<Button> buildButtonsDynamically(List data) {
    List<Button> buttons = [];
    data.forEach((element) {
      Button button = Button(
        onPressed: () async {
          print(element['authenticationOptionID']);

          setState(() {
            isLoading = true;
          });
          var dataData =
              await authSelectGetter.postData(contactGuid, authOptionId);
          setState(() {
            isLoading = false;
            isVisible = true;
            authOptionId = element['authenticationOptionID'];
          });
          updateUI(dataData);
          _sendDataToNextScreen(context);
          //uploadAuthOptionSelection(element[‘authenticationOptionID’]);
        },
        title: element['text'],
      );
      buttons.add(button);
    });
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kMainBackgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 1.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Image.asset('images/iConnections gray .png'),
                    height: 141.0,
                  ),
                ],
              ),
              kDivider,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Your Email: $email',
                        style: kDataTextStyle,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Text(
                          'Your ContactGUID: $contactGUID',
                          style: kDataTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              kDivider,
              isLoading
                  ? CircularProgressIndicator(
                      color: Color(0xff692B7E),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(vertical: 18.0),
                      child: Visibility(
                        visible: isVisible,
                        child: Text(
                          'Select Auth Option',
                          style: kDataTextStyle,
                        ),
                      ),
                    ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.0, vertical: 11.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: buildButtonsDynamically(data),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendDataToNextScreen(BuildContext context) {
    String emailToSend = email;
    String contactToSend = contactGUID;
    var authOptionToSend = authOptionId;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TokenScreen(
          email: emailToSend,
          contactGUID: contactToSend,
          authOptionId: authOptionToSend,
        ),
      ),
    );
  }
}
