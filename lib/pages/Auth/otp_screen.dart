import 'package:deliveryApp/custom_ui/custom_authpage_ui.dart';
import 'package:deliveryApp/custom_ui/custom_snackbar.dart';
import 'package:deliveryApp/logic/connectivity/connectivity_widget.dart';
import 'package:deliveryApp/logic/otp_controller/otp_controller.dart';
import 'package:deliveryApp/pages/Auth/registration_email_password_screen.dart';
import 'package:deliveryApp/static_content/colors.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  final phoneNumber, verificationId;

  const OTPScreen({Key key, this.phoneNumber, this.verificationId})
      : super(key: key);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final key = GlobalKey<ScaffoldState>();

  String otp = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidget(
      child: Scaffold(
        key: key,
        backgroundColor: appColor,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Builder(builder: (context) {
            return CustomAuthWidget(
                isloading: loading,
                callback: () {
                  print('hello');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegEmailPasswordScreen(
                                phoneNumber: widget.phoneNumber,
                              )));
                  // moveToNext(context,
                  //     verificationId: widget.verificationId, smsCode: otp);
                },
                title: 'Enter OTP ',
                subTitle:
                    '6 digit code has been sent to ${widget.phoneNumber}. Its usualy take up to 2 - 3 mins to receive code',
                btnText: 'Continue',
                form: PinCodeTextField(
                  textInputType: TextInputType.number,
                  length: 6,
                  obsecureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      borderWidth: 0.1,
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveColor: Colors.grey,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.red.withOpacity(0.1)),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  // controller: textEditingController,
                  onCompleted: (v) {
                    otp = v;
                    verifyOTP(context, v);
                  },
                  onChanged: (value) {
                    // otp = value;
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ));
          }),
        ),
      ),
    );
  }

  verifyOTP(BuildContext context, String otp) {
    setState(() {
      loading = true;
    });
    OTPController.otpVerification(pinID: widget.verificationId, pin: otp)
        .then((value) {
      setState(() {
        loading = false;
      });
      print(value);
      if (value == null) {
        customAlertDialog(context, message: 'There was an error verifying OTP');
      } else {
        successSnackBar(context, 'OTP has been verify successfully');
        Future.delayed(Duration(seconds: 2), () {
          print('navigate');
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => RegEmailPasswordScreen(
                    phoneNumber: widget.phoneNumber,
                  )));
        });
      }
    }).catchError(() {
      setState(() {
        loading = false;
      });
    });
  }
}
