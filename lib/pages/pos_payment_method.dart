import 'package:deliveryApp/custom_ui/custom_button.dart';
import 'package:deliveryApp/custom_ui/custom_card.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';

class POSPaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Card on Delivery',
          style: TextStyle(color: appColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20),
        child: Column(
          children: <Widget>[
            AmountCard(),
            SizedBox(
              height: 20,
            ),
            Image.asset(CryptoImage.posImage),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: Text(
                data,
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            CustomButton(title: 'Done'),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

var data =
    "Rider will come with a POS. Please make sure you have your card ready .";
