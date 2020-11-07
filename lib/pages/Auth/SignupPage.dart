import 'package:deliveryApp/custom_ui/custom_button.dart';
import 'package:deliveryApp/custom_ui/custom_form.dart';
import 'package:deliveryApp/custom_ui/loading_dialog.dart';
import 'package:deliveryApp/logic/authentication/register_newuser.dart';
import 'package:deliveryApp/pages/Auth/forget_password_page.dart';
import 'package:deliveryApp/pages/Auth/registration_screen.dart';
import 'package:deliveryApp/pages/main_page.dart';
import 'package:deliveryApp/pref/localized_user_data.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:deliveryApp/utils/responsiveWidget.dart';
import 'package:deliveryApp/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../http_request.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool isLoading = false;
  var onSignalID = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _oneSignalID();
  }

  void _oneSignalID() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    var playerId = status.subscriptionStatus.userId;
    setState(() {
      onSignalID = playerId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: ResponsiveWidget(builder: (context, devInfo) {
        bool smallScreen = devInfo.deviceType == DeviceScreenType.XMobile;
        return LoadingWidget(
          isLoading: isLoading,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Builder(builder: (
                  context,
                ) {
                  return Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(50))),
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Image.asset(
                          AssetImages.authbg,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Welcome back!',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 30,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Sign in to your account',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15.0),
                                              child: Column(
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  CustomTextForm(
                                                    validator: emailValidation,
                                                    controller: email,
                                                    titleStyle: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    title: 'Email ',
                                                  ),
                                                  CustomTextForm(
                                                    passwords: true,
                                                    validator:
                                                        passwordValidation,
                                                    controller: password,
                                                    titleStyle: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    title: 'Password',
                                                    shrinkBottom: true,
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Spacer(),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      ForgetPassword()));
                                                        },
                                                        child: Text(
                                                          'Forgot Password?',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 0.8),
                                                      offset: Offset(4, 4),
                                                      blurRadius: 15),
                                                ]),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      CustomButton(
                        loading: isLoading,
                        color: Colors.white,
                        textStyle: TextStyle(color: Colors.black),
                        title: 'LOGIN',
                        callback: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            print(_formKey.currentState.validate());
                            setState(() {
                              isLoading = true;
                            });

                            NewUser(ServerData(), '/login', context, data: {
                              "username": email.text,
                              "password": password.text,
                              'device_id': onSignalID
                            }).post().then((value) {
                              if (value?.data != null) {
                                saveUser(value.data);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) => MainPage()));
                              }
                              setState(() {
                                isLoading = false;
                              });
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'No Account yet? Click here to ',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contex) =>
                                          RegistrationScreen()));
                            },
                            child: Text(
                              ' Register',
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        );
      }),
    );
  }
}
