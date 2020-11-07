import 'package:deliveryApp/pages/dashboard.dart';
import 'package:deliveryApp/pages/profile/orders_screen.dart';
import 'package:deliveryApp/pages/profile/profile_view.dart';
import 'package:deliveryApp/static_content/API_KEY.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  List<Widget> get widgetOptions =>
      <Widget>[Dashboard(), OrderScreen(), ProfileViewScreen()];

  @override
  void initState() {
    super.initState();
    onSignalSetUp();
  }

  onSignalSetUp() async {
    var settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.promptBeforeOpeningPushUrl: true
    };
    await OneSignal.shared.init(onSignalKey, iOSSettings: settings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      body: widgetOptions[_index],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white.withOpacity(0.5),
        selectedItemColor: Colors.white,
        backgroundColor: appColor,
        onTap: (newIndex) => setState(() => _index = newIndex),
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), title: Text("Orders")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Users")),
        ],
      ),
    );
  }

  placeHolder(index, image) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
                color: _index == index ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(12)),
            child: Image.asset(image)),
      );
}
