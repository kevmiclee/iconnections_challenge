import 'package:flutter/material.dart';
import 'package:iconnections_challenge/screens/email_display.dart';
import 'package:iconnections_challenge/utilities/constants.dart';
import 'package:iconnections_challenge/components/button.dart';

class MainScreen extends StatefulWidget {
  static String id = 'main_screen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var email;
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kMainBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome!',
                style: kAppBarTextStyle,
              ),
            ],
          ),
          backgroundColor: Color(0xff692B7E),
        ),
        body: Column(
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
                    Text(
                      'Sign in with Email',
                      style: kDataTextStyle,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 11.0, left: 26.0, right: 26.0, bottom: 11.0),
                      child: TextField(
                        controller: textFieldController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: kInputTextField,
                      ),
                    ),
                    Button(
                      title: 'Sign In',
                      onPressed: () {
                        if (email == 'chris@iconnections.io') {
                          _sendDataToNextPage(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendDataToNextPage(BuildContext context) {
    String emailToSend = textFieldController.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmailDisplay(
          email: emailToSend,
        ),
      ),
    );
  }
}
