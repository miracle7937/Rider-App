import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

saveUser(Map user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('user Saved');
  prefs.setString('user', jsonEncode(user));
}

Future retriveUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return jsonDecode(prefs.get('user'));
}

logoutUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('user');
}
