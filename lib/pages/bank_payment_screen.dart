import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:deliveryApp/custom_ui/custom_button.dart';
import 'package:deliveryApp/custom_ui/custom_card.dart';
import 'package:deliveryApp/custom_ui/custom_snackbar.dart';
import 'package:deliveryApp/custom_ui/loading_dialog.dart';
import 'package:deliveryApp/custom_ui/success_order_recieved.dart';
import 'package:deliveryApp/logic/payment/payment.dart';
import 'package:deliveryApp/models/bankDetailModel.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BankPaymentScreen extends StatefulWidget {
  final Map value;
  final File file;

  const BankPaymentScreen({
    Key key,
    this.value,
    this.file,
  }) : super(key: key);

  @override
  _BankPaymentScreenState createState() => _BankPaymentScreenState();
}

class _BankPaymentScreenState extends State<BankPaymentScreen> {
  bool loading = false;
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
      body: LoadingWidget(
        isLoading: loading,
        child: FutureBuilder<BankDetailController>(
            future: getBankdetails(context),
            builder: (context, snapshot) {
              var data = snapshot.data;
              if (data == null) {
                return Container(
                  child: Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Lottie.asset(AssetImages.loading),
                    ),
                  ),
                );
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 25.0, horizontal: 10),
                  child: Column(
                    children: <Widget>[
                      AmountCard(
                        amount: widget.value['payment_amount'].toString() ?? '',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      customListTile(context,
                          subTitle: '',
                          title: data.bankName,
                          image: AssetImages.bankIcon),
                      customListTile(context,
                          title: 'Account NO: ', subTitle: data.accountNumber),
                      customListTile(context,
                          title: 'Account Name: ',
                          subTitle: '${data.accountName}'),
                      customListTile(context,
                          title: 'Reference code:  ',
                          subTitle: data.referenceCode),
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
                      CustomButton(
                        title: 'Update Payment',
                        callback: () {
                          bankPayment(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  bankPayment(context) {
    setState(() {
      loading = true;
    });
    widget.value['payment_type'] = 'Bank Payment';
    Payment().payWithCard(context, widget.value, widget.file).then((value) {
      print(value.data);
      setState(() {
        loading = false;
      });
      if (value?.data != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SuccessOrder(
                  requstCode: value.data['order_code'].toString(),
                )));
      } else {
        setState(() {
          loading = false;
        });
        paymentAlertDailog(context, success: false);
      }
    });
  }

  customListTile(BuildContext context,
          {String image, String title, String subTitle}) =>
      Padding(
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
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Wrap(
                  children: [
                    AutoSizeText(
                      subTitle,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
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
