import 'package:deliveryApp/custom_ui/custom_button.dart';
import 'package:deliveryApp/custom_ui/custom_card.dart';
import 'package:deliveryApp/pages/select_payment_method_screen.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';

class PackagePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'Adejimi Tolulope ',
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
                      '+2348105059613',
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
                      'Iphone x max ',
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
                      '0-10kg',
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
                      'Yes',
                      style: maintitle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * .2,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                            color: greyColor,
                            borderRadius: BorderRadius.circular(12)),
                      ),
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
              AmountCard(),
              SizedBox(
                height: 20,
              ),
              Column(
                children: <Widget>[
                  CustomButton(
                    title: 'Continue to Payment',
                    callback: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PaymentScreen()));
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
