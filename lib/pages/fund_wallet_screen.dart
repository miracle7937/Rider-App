import 'package:deliveryApp/custom_ui/custom_button.dart';
import 'package:deliveryApp/custom_ui/custom_card.dart';
import 'package:deliveryApp/custom_ui/custom_form.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';

class FundWalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Fund Wallet',
          style: TextStyle(color: appColor),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomCard(
              forWallet: true,
            ),
            SizedBox(
              height: 20,
            ),
            Text('Fund your wallet with min of N200 and Max N1,000,000',
                style: TextStyle(
                  fontSize: 13,
                )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
              child: CustomTextForm(
                hinText: '₦',
                title: 'Enter Amount',
              ),
            ),  Text('N 2,500 will be credited to your wallet'),
            Spacer(),
            CustomButton(title: 'Continue to Pay'),
             SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
