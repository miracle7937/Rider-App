import 'dart:io';

import 'package:christian_picker_image/christian_picker_image.dart';
import 'package:deliveryApp/custom_ui/custom_button.dart';
import 'package:deliveryApp/custom_ui/custom_form.dart';
import 'package:deliveryApp/custom_ui/custom_snackbar.dart';
import 'package:deliveryApp/custom_ui/package_preview.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PackageDetails extends StatefulWidget {
  final double distanceInKilloMeter;
  final String pickUpLocation, dropLocation;
  final amount;

  PackageDetails(
      {Key key,
      this.distanceInKilloMeter = 1.9,
      this.pickUpLocation,
      this.dropLocation,
      this.amount})
      : super(key: key);

  @override
  _PackageDetailsState createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  bool _frigile = false;

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    try {
      // final pickedFile = await picker.getImage(source: ImageSource.camera);
      List<File> pickedFile =
          await ChristianPickerImage.pickImages(maxImages: 1);

      setState(() {
        if (pickedFile.isNotEmpty) {
          // _image = File(pickedFile.path);
          _image = pickedFile[0];
        } else {
          print('No image selected.');
        }
      });

      print(pickedFile);
    } catch (e) {
      print(e);
    }
  }

  final receiverName = TextEditingController();
  final receiverNumber = TextEditingController();
  final packageName = TextEditingController();
  var packageWeight = "0-10kg";
  final packageValue = TextEditingController();

  int frigile = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () {}),
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 40),
                child: Column(
                  children: <Widget>[
                    CustomTextForm(
                      controller: receiverName,
                      hinText: 'Enter the Receiver’s fullname ',
                      title: 'Receiver’s Full Name',
                    ),
                    CustomTextForm(
                      controller: receiverNumber,
                      title: 'Receiver’s  Phone Number',
                      keyboardType: TextInputType.number,
                      hinText: 'Enter the Receiver’s Phone Number',
                    ),
                    CustomTextForm(
                      controller: packageName,
                      title: 'Package Title',
                      hinText: 'Enter the package title',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomDropDowm(
                          title: 'Weight',
                          onChange: (value) {
                            setState(() {});
                          },
                        ),
                        customSwitch()
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextForm(
                      controller: packageValue,
                      title: 'Package Value',
                      hinText: 'Enter the value in Naira',
                      keyboardType: TextInputType.number,
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
                              if (!checkNullValue()) {
                                errorSnackBar(
                                    context, 'All field must be filled');
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PackagePreview(
                                              amount: widget.amount.toString(),
                                              pickupLoc: widget.pickUpLocation,
                                              destinationLoc:
                                                  widget.dropLocation,
                                              frigile: frigile,
                                              packageName: packageName.text,
                                              packageValue: packageValue.text,
                                              packageWeight: packageWeight,
                                              selectedImage: _image,
                                              distanceInKilloMeter:
                                                  widget.distanceInKilloMeter,
                                              receiverName: receiverName.text,
                                              receiverNumber:
                                                  receiverNumber.text,
                                            )));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
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
                if (value) {
                  frigile = 1;
                } else {
                  frigile = 0;
                }
              });
            }),
      ],
    );
  }

  bool checkNullValue() {
    print('${receiverName.text.isNotEmpty} ');
    print(receiverNumber.text.isNotEmpty);
    print(packageName.text.isNotEmpty);
    print(packageValue.text.isNotEmpty);
    print(!widget.distanceInKilloMeter.isNaN);
    if (receiverName.text.isNotEmpty &&
        receiverNumber.text.isNotEmpty &&
        packageName.text.isNotEmpty &&
        packageValue.text.isNotEmpty &&
        !widget.distanceInKilloMeter.isNaN) {
      return true;
    } else {
      return false;
    }
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
