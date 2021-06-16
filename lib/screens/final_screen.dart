import 'package:flutter/material.dart';
import 'package:iconnections_challenge/services/data_get.dart';
import 'package:iconnections_challenge/utilities/constants.dart';
import 'package:iconnections_challenge/components/button.dart';
import 'dart:io';

class FinalScreen extends StatefulWidget {
  FinalScreen({required this.token});

  final String token;

  @override
  _FinalScreenState createState() => _FinalScreenState(token: token);
}

class _FinalScreenState extends State<FinalScreen> {
  _FinalScreenState({required this.token});

  TokenGetter tokenGetter = TokenGetter();
  var token;
  bool isLoading = false;
  bool isVisible = false;
  var imageURL;
  var name;

  @override
  void initState() {
    super.initState();
    asyncMethod();
  }

  void asyncMethod() async {
    setState(() {
      isLoading = true;
    });
    var dataData = await tokenGetter.postData(token);
    setState(() {
      isLoading = false;
      isVisible = true;
      updateUI(dataData);
    });
  }

  void updateUI(dynamic dataData) {
    setState(() {
      if (dataData == null) {
        return;
      }
      imageURL = dataData['imageURL'];
      name = dataData['contactName'];
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50.0,
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
                  padding: EdgeInsets.symmetric(vertical: 26.0),
                  child: kDivider),
              isLoading
                  ? CircularProgressIndicator(
                      color: Color(0xff692B7E),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Welcome, $name',
                        style: kWelcomeTextStyle,
                      ),
                    ),
              Visibility(
                visible: isVisible,
                child: Image.network('$imageURL'),
              ),
              Button(
                title: 'Close App',
                onPressed: () => exit(0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
