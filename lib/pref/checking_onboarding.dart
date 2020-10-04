import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

///for unboarding process
///
///
///

class OnboardingPref {
  static Future<bool> isnewUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool('isNewUser') ?? false;

    return value;
  }

  static setNewUserAsOld() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isNewUser', true);
  }
}
