import 'package:deliveryApp/custom_ui/custom_button.dart';
import 'package:deliveryApp/custom_ui/custom_card.dart';
import 'package:deliveryApp/custom_ui/package_details.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';

class SetAddressScreen extends StatelessWidget {
  var pickupLocation = 'Set Pick up Address';
  var destinationLocation = 'Set delievry Address';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Center(
              child: FormCard(
                child: Row(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Image.asset(CryptoImage.dot),
                        Expanded(
                            child: VerticalDivider(
                          thickness: 2,
                        )),
                        Image.asset(CryptoImage.triangle),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          placeHolder(showIcon: true, text: pickupLocation),
                          Divider(
                            thickness: 2,
                          ),
                          placeHolder(
                              showIcon: false, text: destinationLocation),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            CustomButton(
              callback: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PackageDetails())),
              title: 'Continue',
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  placeHolder({@required bool showIcon, @required String text}) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: greyColor,
              ),
            ),
            Spacer(),
            showIcon ? Image.asset(CryptoImage.place) : Container()
          ],
        ),
      );
}
