import 'package:deliveryApp/pages/Auth/SignupPage.dart';
import 'package:deliveryApp/pages/Auth/registration_screen.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:deliveryApp/static_content/Images.dart';


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Image.asset(AssetImages.welcomePageIcon),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _button(
                    image: AssetImages.loginIcon,
                      title: 'LOGIN',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()));
                      },
                      subTitle: 'Login if you have an account already'),
                  _button(
                    image: AssetImages.signUpIcon,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationScreen()));
                      },
                      title: 'SIGN UP',
                      subTitle: 'Register a free account ')
                ],
              ),
              decoration: BoxDecoration(
                  color: appColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        offset: Offset(4, 4),
                        blurRadius: 15),
                  ]),
            ),
          ))
        ],
      ),
    );
  }

  _button({String title, subTitle, String image ,VoidCallback onTap}) {
    return InkWell(
      splashColor: appColor,
      focusColor: Colors.red,
      onTap: onTap,
      child: Container(
        height: 150,
        width: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 55,
              width: 55,
              child: Image.asset(image),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Center(
              child: Text(
                subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: whiteColor),
      ),
    );
  }
}
