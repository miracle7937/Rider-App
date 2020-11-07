import 'package:deliveryApp/custom_ui/custom_button.dart';
import 'package:deliveryApp/custom_ui/custom_form.dart';
import 'package:deliveryApp/logic/authentication/register_newuser.dart';
import 'package:deliveryApp/logic/connectivity/connectivity_widget.dart';
import 'package:deliveryApp/pref/localized_user_data.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../http_request.dart';

class EditProfileScreenScreen extends StatefulWidget {
  @override
  _EditProfileScreenScreenState createState() =>
      _EditProfileScreenScreenState();
}

class _EditProfileScreenScreenState extends State<EditProfileScreenScreen> {
  var firstName = TextEditingController();
  var lastnaeme = TextEditingController();
  var password = TextEditingController();

  bool isLoading = false;
  @override
  void initState() {
    getDataFromLocal();
    super.initState();
  }

  getDataFromLocal() {
    retriveUserData().then((value) {
      firstName.value = TextEditingValue(text: value['firstname'] ?? '');
      lastnaeme.value = TextEditingValue(text: value['lastname'] ?? '');

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidget(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   saveUser({'hello': 444});

        // }),
        backgroundColor: whiteColor,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: whiteColor,
          title: Text(
            'Profile',
            style: TextStyle(color: appColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Builder(builder: (context) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      child: Lottie.asset(AssetImages.happyUser,
                          frameRate: FrameRate.max,
                          reverse: true,
                          repeat: true),
                      decoration: BoxDecoration(shape: BoxShape.circle),
                    ),
                    CustomTextForm(
                      controller: firstName,
                      title: 'First Name',
                    ),
                    CustomTextForm(
                      controller: lastnaeme,
                      title: 'Last Name',
                    ),
                    CustomTextForm(
                      passwords: true,
                      keyboardType: TextInputType.visiblePassword,
                      controller: password,
                      title: 'Change Password',
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                    CustomButton(
                        title: 'Done',
                        loading: isLoading,
                        callback: () {
                          setState(() {
                            isLoading = true;
                          });
                          NewUser(ServerData(), '/user/edit', context, data: {
                            "firstname": firstName.text,
                            "lastname": lastnaeme.text,
                            "password": password.text
                          }).put().then((value) {
                            print('chi $value');

                            if (value?.data != null) {
                              print(' mimi ${value.data}');
                              saveUser(value.data);
                              Future.delayed(Duration(seconds: 2))
                                  .whenComplete(() {
                                Navigator.pop(context);
                              });
                            }
                            setState(() {
                              isLoading = false;
                            });
                            print(value);
                          });
                        }),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
