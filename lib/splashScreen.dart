import 'package:deliveryApp/custom_ui/customizing_splashScreen.dart';
import 'package:deliveryApp/pages/Auth/SignupPage.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:deliveryApp/utils/main_page_navigation_checker.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
        future: PageDecider.selectedPage(),
        builder: (context, snapshot) {
          return MySplashScreen(
            seconds: 3,
            navigateAfterSeconds: SignUpScreen(), //snapshot.data,
            title: new Text(
              'Welcome to Band of Riders',
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            image: new Image.asset(CryptoImage.logoIcon),
            backgroundColor: Colors.white,
            styleTextUnderTheLoader: new TextStyle(fontWeight: FontWeight.w400),
            photoSize: 100.0,
            onClick: () => print("Flutter Egypt"),
            loaderColor: appColor,
          );
        });
  }
}
