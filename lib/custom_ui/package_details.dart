import 'dart:io';

import 'package:deliveryApp/custom_ui/custom_button.dart';
import 'package:deliveryApp/custom_ui/custom_form.dart';
import 'package:deliveryApp/custom_ui/package_preview.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PackageDetails extends StatefulWidget {
  @override
  _PackageDetailsState createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  bool _frigile = false;
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: whiteColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Package Details',
          style: TextStyle(color: appColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 40),
            child: Column(
              children: <Widget>[
                CustomTextForm(
                  hinText: 'Enter the Receiver’s ful name ',
                  title: 'Receiver’s Full Name',
                ),
                CustomTextForm(
                  title: 'Receiver’s  Phone Number',
                  keyboardType: TextInputType.number,
                  hinText: 'Enter the Receiver’s Phone Number',
                ),
                CustomTextForm(
                  title: 'Package Title',
                  hinText: 'Enter the package title',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[CustomDropDowm(), customSwitch()],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextForm(
                  title: 'Package Value',
                  hinText: 'Enter the value in Naira',
                ),
                SizedBox(
                  height: 20,
                ),
                imageHolder(),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Center(
                      child: CustomButton(
                        title: 'Continue',
                        callback: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PackagePreview()));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row customSwitch() {
    return Row(
      children: <Widget>[
        Text('Frigile'),
        SizedBox(
          width: 4,
        ),
        CupertinoSwitch(
            activeColor: appColor,
            value: _frigile,
            onChanged: (value) {
              setState(() {
                _frigile = value;
              });
            }),
      ],
    );
  }

  imageHolder() => InkWell(
      splashColor: Colors.red,
      onTap: () => getImage(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Container(
          decoration: BoxDecoration(
              // color: greyColor,
              image: _image == null
                  ? null
                  : DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.file(
                        _image,
                      ).image,
                    ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black, width: 0.5)),
          child: _image != null
              ? Container()
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.image,
                        size: 50,
                      ),
                      Text(
                        'Tap to select package images',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      )
                    ],
                  ),
                ),
        ),
      ));
}
