import 'package:deliveryApp/custom_ui/custom_button.dart';
import 'package:deliveryApp/logic/connectivity/check_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoNetwork extends StatelessWidget {
  const NoNetwork({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Lottie.asset('assets/images/bad_signal.json'),
                Text(
                  'Network Error',
                  style: TextStyle(fontSize: 17, color: Colors.black),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(80.0),
              child: CustomButton(
                  callback: () {
                    checkConnection().then((value) {
                      if (value == true) {
                        Navigator.pop(context);
                      }
                    });
                  },
                  title: 'retry'),
            ),
          ],
        ),
      ),
    );
  }
}
