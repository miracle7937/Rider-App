import 'package:deliveryApp/onboarding/onboarding_screen.dart';
import 'package:deliveryApp/pages/dashboard.dart';
import 'package:deliveryApp/splashScreen.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          body1: GoogleFonts.abel(),
        ),
        appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.black)),
        scaffoldBackgroundColor: Color.fromRGBO(229, 229, 229, 1),
        cupertinoOverrideTheme: CupertinoThemeData(primaryColor: appColor),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return OnboardingScreen();  //Dashboard();
  }
}
