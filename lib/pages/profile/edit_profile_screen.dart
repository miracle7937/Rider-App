import 'package:deliveryApp/custom_ui/custom_button.dart';
import 'package:deliveryApp/custom_ui/custom_form.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';

class EditProfileScreenScreen extends StatefulWidget {
  @override
  _EditProfileScreenScreenState createState() =>
      _EditProfileScreenScreenState();
}

class _EditProfileScreenScreenState extends State<EditProfileScreenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
          child: Column(
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                child: Image.asset(
                  CryptoImage.userImage,
                  fit: BoxFit.cover,
                ),
                decoration: BoxDecoration(shape: BoxShape.circle),
              ),
              CustomTextForm(
                title: 'First Name',
              ),
              CustomTextForm(
                title: 'Last Name',
              ),
              CustomTextForm(
                title: 'Password',
              ),
              Spacer(),
              CustomButton(title: 'Done'),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
