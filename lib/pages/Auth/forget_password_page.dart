import 'package:deliveryApp/custom_ui/custom_authpage_ui.dart';
import 'package:deliveryApp/custom_ui/custom_form.dart';
import 'package:deliveryApp/logic/authentication/register_newuser.dart';
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
                      color: Colors.white,
                      validator: emailValidation,
                      controller: email,
                      titleStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      title: 'Email ',
                    ),
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
}
