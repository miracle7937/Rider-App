import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

saveUser(Map user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('user Saved');
  prefs.setString('userData', jsonEncode(user));
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
    return jsonDecode(userData)['user'];
  }
}

logoutUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('logout');
  prefs.remove('userData');
}
