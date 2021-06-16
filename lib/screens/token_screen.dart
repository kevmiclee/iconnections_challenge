import 'package:flutter/material.dart';
import 'package:iconnections_challenge/services/data_get.dart';
import 'package:iconnections_challenge/utilities/constants.dart';
import 'package:iconnections_challenge/components/button.dart';
import 'package:iconnections_challenge/screens/final_screen.dart';

class TokenScreen extends StatefulWidget {
  TokenScreen(
      {required this.email,
      required this.contactGUID,
      required this.authOptionId});

  final String email;
  final String contactGUID;
  var authOptionId;

  @override
  _TokenScreenState createState() => _TokenScreenState(
      email: email, contactGUID: contactGUID, authOptionId: authOptionId);
}

class _TokenScreenState extends State<TokenScreen> {
  _TokenScreenState(
      {required this.email,
      required this.contactGUID,
      required this.authOptionId});

  TextEditingController textFieldController = TextEditingController();
  VerifyGetter verifyGetter = VerifyGetter();
  final String email;
  var contactGUID;
  var contactGuid;
  var authOptionId;
  bool isLoading = false;
  bool isVisible = false;
  bool isAlsoVisible = true;
  var passcode;
  var token;

  @override
  void initState() {
    super.initState();
  }

  void updateUI(dynamic dataData) {
    setState(() {
      if (passcode != '112233') {
        isVisible = false;
        return;
      }
      contactGuid = dataData['contactGuid'];
      token = dataData['token'];
      isAlsoVisible = false;
    });
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: kDivider,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Your Email: $email',
                        style: kDataTextStyle,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 11.0),
                        child: Text(
                          'Your ContactGUID: $contactGUID',
                          style: kDataTextStyle,
                        ),
                      ),
                      Text(
                        'Auth Option ID: $authOptionId',
                        style: kDataTextStyle,
                      ),
                      Visibility(
                        visible: isAlsoVisible,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 11.0),
                          child: TextField(
                            controller: textFieldController,
                            onChanged: (value) {
                              passcode = value;
                            },
                            decoration: kInputTextField.copyWith(
                              hintText: 'onetimePassCode 112233 goes here...',
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isAlsoVisible,
                        child: Button(
                            title: 'Get Token',
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              var dataData = await verifyGetter.postData(
                                  contactGUID, email, passcode);
                              setState(() {
                                isLoading = false;
                                isVisible = true;
                              });
                              updateUI(dataData);
                            }),
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
                      padding: EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 26.0),
                      child: Visibility(
                        visible: isVisible,
                        child: Container(
                          decoration: kTokenContainer,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 11.0),
                                child: Text(
                                  'Token',
                                  style: kDataTextStyle,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                  '$token',
                                  style: kTokenTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              Visibility(
                visible: isVisible,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 11.0),
                  child: Button(
                    title: 'Next',
                    onPressed: () {
                      _sendDataToNextScreen(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendDataToNextScreen(BuildContext context) {
    String tokenToSend = token;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FinalScreen(
          token: tokenToSend,
        ),
      ),
    );
  }
}
