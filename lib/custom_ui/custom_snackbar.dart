import 'package:deliveryApp/custom_ui/custom_button.dart';
import 'package:deliveryApp/pages/main_page.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

errorSnackBar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(new SnackBar(
    backgroundColor: Colors.red,
    content: Text(
      message.toString(),
      style: TextStyle(color: Colors.white),
    ),
  ));
}

successSnackBar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(new SnackBar(
    backgroundColor: Colors.green,
    content: Text(
      message.toString(),
      style: TextStyle(color: Colors.white),
    ),
  ));
}

customAlertDialog(
  BuildContext context, {
  bool success = false,
  String succMessage,
  VoidCallback onTap,
}) {
  showModalBottomSheet(
      isDismissible: !success,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.30,
                    child: Lottie.asset(
                        success ? AssetImages.success : AssetImages.error,
                        repeat: success),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    success ? succMessage : errorMsg,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    color: appColor,
                    callback: () {
                      success ? onTap() : Navigator.pop(context);
                    },
                    textStyle: TextStyle(color: Colors.white),
                    title: 'OK',
                  )
                ],
              ),
            ),
          ));
}

paymentAlertDailog(BuildContext context, {bool success = false}) {
  showModalBottomSheet(
      isDismissible: !success,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.30,
                    child: Lottie.asset(
                        success ? AssetImages.success : AssetImages.error,
                        repeat: success),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    success ? successMsg : errorMsg,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    color: appColor,
                    callback: () {
                      success
                          ? Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage()))
                          : Navigator.pop(context);
                    },
                    textStyle: TextStyle(color: Colors.white),
                    title: 'OK',
                  )
                ],
              ),
            ),
          ));
}

String successMsg =
    'your packege  request is successful our rider will be calling you';

String errorMsg = "error occured, request wasn't received";
