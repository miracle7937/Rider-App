import 'package:deliveryApp/custom_ui/customizing_splashScreen.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:deliveryApp/utils/main_page_navigation_checker.dart';
import 'package:deliveryApp/utils/responsiveWidget.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
     
      builder: (context, devInfo) {
             bool smallScreen =devInfo.deviceType==DeviceScreenType.XMobile;

        return FutureBuilder<Widget>(
            future: PageDecider.selectedPage(),
            builder: (context, snapshot) {
              print(snapshot.data);
              return MySplashScreen(
                seconds: 5,
                navigateAfterSeconds:snapshot.data, //snapshot.data,
                title: Text(
                  'Welcome to Band of Riders',
                  style: new TextStyle(fontWeight: FontWeight.bold, fontSize: smallScreen?15: 20.0),
                ),
                image: new Image.asset(AssetImages.logoIcon),
                backgroundColor: Colors.white,
                styleTextUnderTheLoader: new TextStyle(fontWeight: FontWeight.w400),
                photoSize: 100.0,
                onClick: () => print("Flutter Egypt"),
                loaderColor: appColor,
              );
            });
      }
    );
  }
}
