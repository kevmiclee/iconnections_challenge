import 'package:flutter/material.dart';
import 'package:iconnections_challenge/screens/auth_option.dart';
import 'package:iconnections_challenge/services/data_get.dart';
import 'package:iconnections_challenge/utilities/constants.dart';
import 'package:iconnections_challenge/components/button.dart';

class EmailDisplay extends StatefulWidget {
  EmailDisplay({required this.email});

  final String email;

  @override
  _EmailDisplayState createState() => _EmailDisplayState(email: email);
}

class _EmailDisplayState extends State<EmailDisplay> {
  _EmailDisplayState({required this.email});

  ContactLoginGetter contactLoginGetter = ContactLoginGetter();
  final String email;
  var verified;
  var contactGUID;
  bool isLoading = false;
  bool isVisible = false;
  @override
  void initState() {
    super.initState();
  }

  void updateUI(dynamic dataData) {
    setState(() {
      if (dataData == null) {
        contactGUID = '';
        verified = '';
        return;
      }
      contactGUID = dataData['contactGUID'];
      verified = dataData['verified'];
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
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            kDivider,
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 11.0),
                              child: Text(
                                'Your Email: $email',
                                style: kDataTextStyle,
                              ),
                            ),
                            Button(
                              title: 'Log In',
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                var dataData =
                                    await contactLoginGetter.postData(email);
                                setState(() {
                                  isLoading = false;
                                  isVisible = true;
                                });
                                updateUI(dataData);
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child: kDivider,
                            ),
                            isLoading
                                ? CircularProgressIndicator(
                                    color: Color(0xff692B7E),
                                  )
                                : Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 26.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Visibility(
                                          visible: isVisible,
                                          child: Text(
                                            'Verified: $verified',
                                            style: kDataTextStyle,
                                          ),
                                        ),
                                        Visibility(
                                          visible: isVisible,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 26.0),
                                            child: Text(
                                              'ContactGUID: $contactGUID',
                                              style: kDataTextStyle,
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: isVisible,
                                          child: Button(
                                            title: 'Next',
                                            onPressed: () {
                                              _sendDataToNextPage(context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            )));
  }

  void _sendDataToNextPage(BuildContext context) {
    String emailToSend = email;
    String contactToSend = contactGUID;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthOption(
          email: emailToSend,
          contactGUID: contactToSend,
        ),
      ),
    );
  }
}
