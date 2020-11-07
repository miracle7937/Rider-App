import 'dart:convert';

import 'package:deliveryApp/http_request.dart';
import 'package:deliveryApp/logic/authentication/register_newuser.dart';
import 'package:deliveryApp/pages/Auth/SignupPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveUser(Map user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('user Saved');
  prefs.setString('userData', jsonEncode(user));
}
removeUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('userData');
}

Future getUserToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userData = prefs.get('userData');
  return userData == null ? '' : jsonDecode(userData)['token'];
}

Future<Map> retriveUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userData = prefs.get('userData');
  if (userData == null) {
    return {};
  } else {
    return jsonDecode(userData)['user'] ?? {};
  }
}

logoutUser(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Logoutuser(ServerData(), '/logout', context, data: {}).postNO().then((value) {
    if (value != null) {
      prefs.remove('userData');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
    }
  });
  print('logout');
}
