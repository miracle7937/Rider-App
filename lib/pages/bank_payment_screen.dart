import 'package:deliveryApp/custom_ui/custom_button.dart';
import 'package:deliveryApp/custom_ui/custom_card.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';

class BankPaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Bank payment',
          style: TextStyle(color: appColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10),
          child: Column(
            children: <Widget>[
              AmountCard(),
              SizedBox(
                height: 20,
              ),
              customListTile(context,
                  title: 'STANBIC IBTC', image: AssetImages.bankIcon),
              customListTile(
                context,
                title: 'Account NO:',
              ),
              customListTile(
                context,
                title: 'Account Name:',
              ),
              customListTile(
                context,
                title: 'Reference code:',
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(title: 'Update Payment')
            ],
          ),
        ),
      ),
    );
  }

  customListTile(BuildContext context, {String image, String title}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
        child: Container(
          height: 70,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            child: Row(
              children: <Widget>[
                image != null ? Image.asset(AssetImages.bankIcon) : Container(),
                Text(
                  title,
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 15,
                    color: Color.fromRGBO(0, 0, 0, 0.09))
              ]),
        ),
      );
}

var title = "Order will be processed after Transfer has been confirmed ";
