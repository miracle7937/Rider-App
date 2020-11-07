import 'package:deliveryApp/onboarding/onboarding_screen.dart';
import 'package:deliveryApp/pages/Auth/SignupPage.dart';
import 'package:deliveryApp/pref/checking_onboarding.dart';
import 'package:deliveryApp/pref/localized_user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:deliveryApp/pages/main_page.dart';

class PageDecider {
  static Future<Widget> selectedPage() async {
    var alreadyOnBoard =
        await OnboardingPref.isnewUser(); //for new unBoarder user
    var user = await retriveUserData();
    print(user);
     print(user);

    print(alreadyOnBoard);
    if (!alreadyOnBoard) {
      return OnboardingScreen();
    } else if (user.isEmpty) {
      return SignInScreen();
    } else {
      return MainPage();
    }
  }
}

//algorithm

//first check for new user
///if true onboarding
//old user login yes dash or signup
