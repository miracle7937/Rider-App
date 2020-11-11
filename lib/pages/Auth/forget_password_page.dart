import 'package:deliveryApp/custom_ui/custom_authpage_ui.dart';
import 'package:deliveryApp/custom_ui/custom_form.dart';
import 'package:deliveryApp/logic/authentication/register_newuser.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:deliveryApp/utils/validation.dart';
import 'package:flutter/material.dart';

import '../../http_request.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var email = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: Builder(builder: (
        context,
      ) {
        return InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: CustomAuthWidget(
            isloading: isLoading,
            callback: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                setState(() {
                  isLoading = true;
                });
                NewUser(ServerData(), '/forgotPassword', context,
                    data: {"email": email.text}).post().then((value) {
                  setState(() {
                    isLoading = false;
                  });
                  print(value);
                }).catchError((onError) {
                  setState(() {
                    isLoading = false;
                  });
                });
              }
            },
            form: Builder(builder: (
              context,
            ) {
              return Column(
                children: [
                  Form(
                    key: _formKey,
                    child: CustomTextForm(
                        validator: emailValidation,
                        controller: email,
                        titleStyle: style,
                        inputStyle: TextStyle(color: Colors.white),
                        title: 'Email',
                        decoration: getInputStyle(icon: AssetImages.email)),
                  ),
                ],
              );
            }),
            title: 'Enter Email ',
            subTitle: 'a reset password link will be sent to your email',
            btnText: 'Continue',
          ),
        );
      }),
    );
  }

  TextStyle get style =>
      TextStyle(fontWeight: FontWeight.w800, color: Colors.white);
  getInputStyle({String icon}) {
    return InputDecoration(
      prefixIcon: Image.asset(
        icon,
      ),
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2)),
    );
  }
}
