import 'package:deliveryApp/custom_ui/custom_authpage_ui.dart';
import 'package:deliveryApp/logic/connectivity/check_connectivity.dart';
import 'package:deliveryApp/logic/connectivity/connectivity_widget.dart';
import 'package:deliveryApp/pages/Auth/registration_email_password_screen.dart';
import 'package:deliveryApp/pref/checking_onboarding.dart';
import 'package:deliveryApp/pref/localized_user_data.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> moveToNext(BuildContext context,
      {String smsCode, verificationId}) async {
    AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    print(credential);
    //do the cgeckings here if credential not null move to next page

    await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      showSnack(success: true, message: 'Phone Verification Successful');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RegEmailPasswordScreen(
                    phoneNumber: widget.phoneNumber,
                  )));
    }).catchError((e) {
      showSnack(success: false, message: 'Phone Verification Fails');
    });
  }

  showSnack({bool success, message}) {
    key.currentState.showSnackBar(SnackBar(
      backgroundColor: success ? Colors.green : Colors.red,
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidget(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          OnboardingPref.isnewUser().then((value) => print(value));
        }),
        key: key,
        backgroundColor: appColor,
        body: CustomAuthWidget(
            isloading: false,
            callback: () {
              print('hello');
              moveToNext(context,
                  verificationId: widget.verificationId, smsCode: otp);
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
                  borderWidth: 2,
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  inactiveColor: Colors.transparent,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.red.withOpacity(0.1)),
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              // controller: textEditingController,
              onCompleted: (v) {
                otp = v;
                print(v);
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
            )),
      ),
    );
  }
}
