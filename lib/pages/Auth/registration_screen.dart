import 'package:deliveryApp/custom_ui/custom_authpage_ui.dart';
import 'package:deliveryApp/custom_ui/custom_snackbar.dart';
import 'package:deliveryApp/logic/otp_controller/otp_controller.dart';
import 'package:deliveryApp/pages/Auth/otp_screen.dart';
import 'package:deliveryApp/static_content/colors.dart';
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
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      backgroundColor: appColor,
      body: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: CustomAuthWidget(
            isloading: loading,
            callback: () {
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
              autoFocus: false,
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
                this.phoneNumber = number.phoneNumber;
              },
              onInputValidated: (bool value) {
                print(value);
                if (value == true) {
                  sendOTP(context, phoneNumber);
                }
              },
              selectorTextStyle: TextStyle(color: Colors.white),
            ),
          ),
        );
      }),
    );
  }

  sendOTP(BuildContext context, number) {
    setState(() {
      loading = true;
    });
    OTPController.otpRegistration(number).then((value) {
      setState(() {
        loading = false;
      });
      print(value);
      if (value == null) {
        customAlertDialog(context, message: 'There was an error sending OTP');
      } else {
        successSnackBar(context, 'OTP has been sent successfully');
        Future.delayed(Duration(seconds: 2), () {
          print('navigate');
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => OTPScreen(
                    phoneNumber: phoneNumber,
                    verificationId: value['pin_id'],
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
