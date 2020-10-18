import 'dart:io';

import 'package:deliveryApp/custom_ui/custom_button.dart';
import 'package:deliveryApp/custom_ui/custom_card.dart';
import 'package:deliveryApp/models/Rate.dart';
import 'package:deliveryApp/models/walletModel.dart';
import 'package:deliveryApp/pages/select_payment_method_screen.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';

class PackagePreview extends StatefulWidget {
  final String receiverName;
  final String receiverNumber;
  final String packageName;
  final String packageWeight;
  final String packageValue;

  final File selectedImage;
  final double distanceInKilloMeter;
  final frigile;
  final String pickupLoc, destinationLoc;

  const PackagePreview(
      {Key key,
      this.receiverName,
      this.receiverNumber,
      this.packageName,
      this.packageWeight,
      this.packageValue,
      this.selectedImage,
      this.distanceInKilloMeter,
      this.frigile,
      this.pickupLoc,
      this.destinationLoc})
      : super(key: key);

  @override
  _PackagePreviewState createState() => _PackagePreviewState();
}

class _PackagePreviewState extends State<PackagePreview> {
  String amount;
  String userWalletAmount;

  @override
  void initState() {
    getAmount();

    super.initState();
  }

  getAmount() async {
    getRate(context).then((value) {
      setState(() {
        amount = (value.rate * widget.distanceInKilloMeter).toStringAsFixed(2);
        print(value.rate);
      });
    }).whenComplete(() {
      getWalletAmount();
    });
  }

  getWalletAmount() async {
    var data = await getWallet(context);

    setState(() {
      userWalletAmount = data.amount;
    });
  }

  Map addToMap() {
    Map map = {};
    //',,,,,,,,'package_images',,
    map['delivery_address'] = widget.pickupLoc;
    map['pickup_address'] = widget.destinationLoc;
    map['receiver_fullname'] = widget.receiverName;
    map['receiver_phone'] = widget.receiverNumber;
    map['package_weight'] = widget.packageWeight;
    map['package_value'] = int.parse(widget.packageValue);
    map['fragile'] = widget.frigile;

    map['payment_amount'] = double.parse(amount);
    map['package_title'] = widget.packageName;
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Package Preview',
          style: TextStyle(color: appColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              boxPlaceHolder(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Receiver’s Information',
                      style: title,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Receiver’s Full Name',
                      style: titleSub,
                    ),
                    Text(
                      widget.receiverName ?? '',
                      style: maintitle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 3,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Receiver’s Phone Number',
                      style: titleSub,
                    ),
                    Text(
                      widget.receiverNumber,
                      style: maintitle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )),
              SizedBox(
                height: 20,
              ),
              boxPlaceHolder(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Pick Up Address',
                      style: titleSub,
                    ),
                    Wrap(
                      children: [
                        Text(
                          widget.pickupLoc,
                          style: maintitle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Delivery Address',
                      style: titleSub,
                    ),
                    Wrap(
                      children: [
                        Text(
                          widget.destinationLoc,
                          style: maintitle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )),
              SizedBox(
                height: 20,
              ),
              boxPlaceHolder(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Package  Information',
                      style: title,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Package Title',
                      style: titleSub,
                    ),
                    Text(
                      widget.packageName,
                      style: maintitle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Package Weight',
                      style: titleSub,
                    ),
                    Text(
                      widget.packageWeight,
                      style: maintitle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(),
                    Text(
                      'Frigile',
                      style: titleSub,
                    ),
                    Text(
                      widget.frigile == 0 ? 'No' : 'Yes',
                      style: maintitle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    widget.selectedImage != null
                        ? Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height * .2,
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(widget.selectedImage)),
                                  color: greyColor,
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )),
              SizedBox(
                height: 20,
              ),
              AmountCard(
                amount: amount,
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: <Widget>[
                  CustomButton(
                    title: 'Continue to Payment',
                    callback: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PaymentScreen(
                                userWalletAmount: userWalletAmount,
                                data: addToMap(),
                                selectedFile: widget.selectedImage,
                                amount: amount,
                              )));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  boxPlaceHolder({Widget child}) => Container(
        child: child,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 0.5)),
      );
}

TextStyle get title =>
    TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700);
TextStyle get titleSub =>
    TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w900);
TextStyle get maintitle => TextStyle(
      fontSize: 16,
      color: Colors.grey,
    );
