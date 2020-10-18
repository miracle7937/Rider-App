import 'dart:io';

import 'package:deliveryApp/custom_ui/custom_button.dart';
import 'package:deliveryApp/custom_ui/custom_card.dart';
import 'package:deliveryApp/custom_ui/custom_form.dart';
import 'package:deliveryApp/custom_ui/custom_snackbar.dart';
import 'package:deliveryApp/http_request.dart';
import 'package:deliveryApp/pref/localized_user_data.dart';
import 'package:deliveryApp/static_content/API_KEY.dart';
import 'package:deliveryApp/static_content/String.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class FundWalletScreen extends StatefulWidget {
  @override
  _FundWalletScreenState createState() => _FundWalletScreenState();
}

class _FundWalletScreenState extends State<FundWalletScreen> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    PaystackPlugin.initialize(publicKey: payStackKey);
    super.initState();
  }

  updateController() {
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        getUserToken().then((value) {
          print(value);
        });
      }),
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
        child: Builder(builder: (context) {
          return SingleChildScrollView(
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20),
                  child: CustomTextForm(
                    onChange: (_) {
                      updateController();
                    },
                    controller: controller,
                    keyboardType: TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    hinText: '₦',
                    title: 'Enter Amount',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Wrap(
                    children: [
                      Text(
                          'N ${controller.text} will be credited to your wallet')
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Column(
                  children: [
                    CustomButton(
                        callback: () {
                          if (controller.text.isNotEmpty &&
                              int.parse(controller.text) < 50) {
                            errorSnackBar(
                                context, 'amount to small to fund wallet ');
                          } else {
                            chargeCard(int.parse(controller.text));
                          }
                        },
                        title: 'Continue to Pay'),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  chargeCard(int amount) async {
    Charge charge = Charge()
      ..amount = amount * 100
      ..reference = _getReference()
      // or ..accessCode = _getAccessCodeFrmInitialization()
      ..email = companyEmail;
    CheckoutResponse response = await PaystackPlugin.checkout(
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );
    if (response.status == true) {
      print("reference ${response.reference}");
      ServerData().putData(
          path: '/wallet/add',
          body: {"amount": controller.text, "reference": response.reference});

      _showDialog();
    } else {
      _showErrorDialog();
    }
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }
    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  void _showErrorDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return errorDialog(context);
      },
    );
  }

  Dialog errorDialog(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)), //this right here
      child: Container(
        height: 350.0,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.cancel,
                color: Colors.red,
                size: 90,
              ),
              SizedBox(height: 15),
              Text(
                'Failed to process payment',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                "Error in processing payment, please try again",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return successDialog(context);
      },
    );
  }

  Dialog successDialog(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)), //this right here
      child: Container(
        height: 350.0,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_box,
                color: appColor,
                size: 90,
              ),
              SizedBox(height: 15),
              Text(
                'Payment has successfully',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'been made',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                "Your payment has been successfully",
                style: TextStyle(fontSize: 13),
              ),
              Text("processed.", style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}
