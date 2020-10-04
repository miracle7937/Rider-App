import 'package:deliveryApp/custom_ui/custom_authpage_ui.dart';
import 'package:deliveryApp/pages/Auth/otp_screen.dart';
import 'package:deliveryApp/pages/Auth/registration_email_password_screen.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final key = GlobalKey<ScaffoldState>();
  String verificationId;
  String phoneNumber;

  showSnack({bool success, message}) {
    key.currentState.showSnackBar(SnackBar(
      backgroundColor: success ? Colors.green : Colors.red,
      content: Text(message),
    ));
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      // on author authenticate move directly to email page
      showSnack(success: true, message: 'Phone Number  Verify');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => RegEmailPasswordScreen()));
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      showSnack(success: false, message: 'Verify Fails');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      showSnack(success: true, message: 'sms  Otp sends ');
      // setState(() {
      //   this.codeSent = true;
      // });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(minutes: 2),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // verifyPhone('+2348168307987');
        },
      ),
      key: key,
      backgroundColor: appColor,
      body: Builder(builder: (context) {
        return CustomAuthWidget(
          callback: () {
            // NewUser(ServerData(), '/comments', context).get();
            // print('Navigating OTP page');

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OTPScreen(
                          phoneNumber: phoneNumber,
                          verificationId: verificationId,
                        )));
          },
          title: 'Register',
          subTitle: 'Join us to send and receive package',
          btnText: 'Continue',
          form: InternationalPhoneNumberInput(
            countries: ['NG'],
            textStyle: TextStyle(
              color: Colors.white,
            ),
            inputDecoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Phone Number',
              hintStyle: TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: appColor, width: 0.5),
              ),
              fillColor: Colors.grey.withOpacity(0.2),
              filled: true,
            ),
            onInputChanged: (PhoneNumber number) {
              print(number.phoneNumber);
              this.phoneNumber = number.phoneNumber;
            },
            onInputValidated: (bool value) {
              print(value);
              if (value == true) {
                verifyPhone(phoneNumber);
              }
            },
            autoValidate: false,
            selectorTextStyle: TextStyle(color: Colors.white),
          ),
        );
      }),
    );
  }
}
