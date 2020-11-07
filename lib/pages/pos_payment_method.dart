import 'dart:io';

import 'package:deliveryApp/custom_ui/custom_button.dart';
import 'package:deliveryApp/custom_ui/custom_card.dart';
import 'package:deliveryApp/custom_ui/custom_snackbar.dart';
import 'package:deliveryApp/custom_ui/loading_dialog.dart';
import 'package:deliveryApp/custom_ui/success_order_recieved.dart';
import 'package:deliveryApp/logic/connectivity/connectivity_widget.dart';
import 'package:deliveryApp/logic/payment/payment.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';

class POSPaymentScreen extends StatefulWidget {
  final Map value;
  final bool onDelivery;
  final File file;

  const POSPaymentScreen({Key key, this.value, this.onDelivery, this.file})
      : super(key: key);

  @override
  _POSPaymentScreenState createState() => _POSPaymentScreenState();
}

class _POSPaymentScreenState extends State<POSPaymentScreen> {
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      isLoading: isLoading,
      child: ConnectivityWidget(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              widget.onDelivery
                  ? 'Card on Delivery'
                  : 'Pay with card on pick up',
              style: TextStyle(color: appColor),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20),
            child: Column(
              children: <Widget>[
                AmountCard(
                  amount: widget.value['payment_amount'].toString(),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(AssetImages.posImage),
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
                CustomButton(
                  loading: isLoading,
                  title: 'Done',
                  callback: () => posPayment(context),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  posPayment(context) {
    setState(() {
      isLoading = true;
    });
    widget.value['payment_type'] = widget.onDelivery
        ? 'Card payment on Delivey'
        : 'Card payment on pick up';
    Payment().payWithCard(context, widget.value, widget.file).then((value) {
      setState(() {
        isLoading = false;
      });
      if (value?.data != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SuccessOrder(
                  requstCode: value.data['order_code'].toString(),
                )));
      } else {
        paymentAlertDailog(context, success: false);
      }
    });
  }
}

var data =
    "Rider will come with a POS. Please make sure you have your card ready .";
