import 'dart:io';

import 'package:deliveryApp/custom_ui/custom_snackbar.dart';
import 'package:deliveryApp/pages/main_page.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lottie/lottie.dart';
import 'package:screenshot/screenshot.dart';

class SuccessOrder extends StatefulWidget {
  final String requstCode;

  const SuccessOrder({Key key, this.requstCode}) : super(key: key);
  @override
  _SuccessOrderState createState() => _SuccessOrderState();
}

class _SuccessOrderState extends State<SuccessOrder> {
  File _imageFile;
  bool _allowWriteFile = false;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Screenshot(
        controller: screenshotController,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            leading: Text(''),
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Order Received',
              style: TextStyle(color: appColor),
            ),
          ),
          body: Builder(builder: (context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    'Your Order has been received',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: 150,
                      child: Lottie.asset(AssetImages.main_success,
                          repeat: false)),
                  Text(
                    'Your Order code is',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  placeholder(context, widget.requstCode),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Use code to confirm order when your rider arrives ',
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      screenshotController
                          .capture(delay: Duration(seconds: 3))
                          .then((File image) async {
                        print("image path  ${image.path}");

                        await ImageGallerySaver.saveImage(
                            image.readAsBytesSync());
                        print("File Saved to Gallery");
                        successSnackBar(context,
                            'order code has been save to your gallery');
                        Future.delayed(Duration(seconds: 3)).whenComplete(() {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage()));
                        });
                      }).catchError((onError) {
                        print(onError);
                      });
                    },
                    child: SizedBox(
                        height: 100,
                        child: Lottie.asset(
                          AssetImages.fingerPrint,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: 150,
                      child: Text(
                        'Tap to save order in your gallery',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic),
                      )),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

placeholder(BuildContext context, String code) => Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: 70,
      child: Center(
          child: Text(
        code ?? '',
        style: TextStyle(
            fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
      )),
      decoration: BoxDecoration(
        color: appColor,
        borderRadius: BorderRadius.circular(12),
      ),
    );
