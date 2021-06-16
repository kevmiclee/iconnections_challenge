import 'package:iconnections_challenge/services/networking.dart';

class ContactLoginGetter {
  Future<dynamic> postData(String emailAddress) async {
    LoginHelper loginHelper = LoginHelper(emailAddress);

    var dataData = await loginHelper.getData();
    return dataData;
  }
}

class AuthOptionsGetter {
  Future<dynamic> postData(String emailAddress) async {
    AuthHelper authHelper = AuthHelper(emailAddress);

    var dataData = await authHelper.getData();
    return dataData;
  }
}

class AuthSelectGetter {
  Future<dynamic> postData(var contactGuid, var authOptionId) async {
    AuthSelectHelper authSelectHelper =
        AuthSelectHelper(contactGuid, authOptionId);

    var dataData = await authSelectHelper.getData();
    return dataData;
  }
}

class VerifyGetter {
  Future<dynamic> postData(var contactGuid, var email, var passcode) async {
    VerifyHelper verifyHelper = VerifyHelper(contactGuid, email, passcode);

    var dataData = await verifyHelper.getData();
    return dataData;
  }
}

class TokenGetter {
  Future<dynamic> postData(var token) async {
    TokenHelper tokenHelper = TokenHelper(token);

    var dataData = await tokenHelper.getData();
    return dataData;
  }
}
