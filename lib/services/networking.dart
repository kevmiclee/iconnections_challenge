import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginHelper {
  LoginHelper(this.email);

  final String email;

  Future getData() async {
    var url = Uri.parse(
        'https://apistaging.iconnections.io/api/mobile/contact_login');
    var _body = jsonEncode({"emailAddress": email});
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: _body);

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

class AuthHelper {
  AuthHelper(this.email);

  final String email;

  Future getData() async {
    var url =
        Uri.parse('https://apistaging.iconnections.io/api/mobile/auth_options');
    var _body = jsonEncode({"emailAddress": email});
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: _body);

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

class AuthSelectHelper {
  AuthSelectHelper(this.contactGuid, this.authOptionId);

  var contactGuid;
  var authOptionId;

  Future getData() async {
    var url = Uri.parse(
        'https://apistaging.iconnections.io/api/mobile/auth_options_selected');
    var _body = jsonEncode({
      "contactGuid": contactGuid,
      "authOptionId": authOptionId,
    });
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: _body);

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

class VerifyHelper {
  VerifyHelper(this.contactGuid, this.email, this.passcode);

  var contactGuid;
  var authOptionId;
  var passcode;
  var email;

  Future getData() async {
    var url =
        Uri.parse('https://apistaging.iconnections.io/api/mobile/verify_otp');
    var _body = jsonEncode({
      "onetimePassCode": passcode,
      "contactGUID": contactGuid,
      "emailAddress": email,
    });
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: _body);

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

class TokenHelper {
  TokenHelper(this.token);

  var token;

  Future getData() async {
    var result;

    var url = Uri.parse(
        'https://apistaging.iconnections.io/api/mobile/get_authenticated_contact');
    try {
      var response = await http.get(url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": "Bearer $token"
      });
      print(json.decode(response.body));
      result = json.decode(response.body);
    } catch (e) {
      print(e);
      result = 'error';
    }
    return result;
  }
}
