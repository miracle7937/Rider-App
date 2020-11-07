import 'package:deliveryApp/custom_ui/custom_button.dart';
import 'package:deliveryApp/custom_ui/custom_form.dart';
import 'package:deliveryApp/custom_ui/loading_dialog.dart';
import 'package:deliveryApp/http_request.dart';
import 'package:deliveryApp/logic/authentication/register_newuser.dart';
import 'package:deliveryApp/pages/Auth/SignupPage.dart';
import 'package:deliveryApp/pages/dashboard.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:deliveryApp/utils/validation.dart';
import 'package:flutter/material.dart';

class RegEmailPasswordScreen extends StatefulWidget {
  final String phoneNumber;

  const RegEmailPasswordScreen({Key key, this.phoneNumber = '+25934837600955'})
      : super(key: key);

  @override
  _RegEmailPasswordScreenState createState() => _RegEmailPasswordScreenState();
}

class _RegEmailPasswordScreenState extends State<RegEmailPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _firstNameFocusNode = FocusNode();

  FocusNode _lastNameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  bool isLoading = false;

  final firstName = TextEditingController();
  final lastnaeme = TextEditingController();
  final password = TextEditingController();
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: LoadingWidget(
          isLoading: isLoading,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Builder(builder: (
                    context,
                  ) {
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Lets get to know \n your better',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        CustomTextForm(
                            validator: userNameValidation,
                            onFieldSubmitted: (_) {
                              fieldFocusChange(context, _firstNameFocusNode,
                                  _lastNameFocusNode);
                            },
                            controller: firstName,
                            titleStyle: style,
                            inputStyle: TextStyle(color: Colors.white),
                            title: 'First Name',
                            decoration: getInputStyle(icon: AssetImages.user)),
                        CustomTextForm(
                            validator: userNameValidation,
                            controller: lastnaeme,
                            titleStyle: style,
                            inputStyle: TextStyle(color: Colors.white),
                            title: 'Last Name',
                            decoration: getInputStyle(icon: AssetImages.user)),
                        CustomTextForm(
                            validator: emailValidation,
                            controller: email,
                            titleStyle: style,
                            inputStyle: TextStyle(color: Colors.white),
                            title: 'Email',
                            onFieldSubmitted: (_) {
                              fieldFocusChange(
                                  context, _emailFocusNode, _passwordFocusNode);
                            },
                            decoration: getInputStyle(icon: AssetImages.email)),
                        CustomTextForm(
                          passwords: true,
                          onFieldSubmitted: (_) {
                            
                            _passwordFocusNode.unfocus();
                          },
                          validator: passwordValidation,
                          controller: password,
                          titleStyle: style,
                          title: 'Password',
                          inputStyle: TextStyle(color: Colors.white),
                          decoration: getInputStyle(icon: AssetImages.security),
                        ),
                        SizedBox(height: 35),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            CustomButton(
                                loading: isLoading,
                                color: Colors.white,
                                textStyle: TextStyle(color: Colors.black),
                                callback: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    print('valid');
                                    setState(() {
                                      isLoading = true;
                                    });

                                    NewUser(ServerData(), '/register', context,
                                        data: {
                                          "firstname": firstName.text,
                                          "lastname": lastnaeme.text,
                                          "phone": widget.phoneNumber,
                                          "email": email.text,
                                          "password": password.text
                                        }).post().then((value) {
                                      print('chi $value');

                                      if (value?.data != null) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (contex) =>
                                                    SignInScreen()));
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });
                                      print(value);
                                    });
                                  }
                                },
                                title: 'Continue'),
                          ],
                        ),
                        SizedBox(height: 35)
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
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

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
