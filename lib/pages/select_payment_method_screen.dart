import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:deliveryApp/custom_ui/loading_dialog.dart';
import 'package:deliveryApp/custom_ui/success_order_recieved.dart';
import 'package:deliveryApp/logic/connectivity/connectivity_widget.dart';
import 'package:deliveryApp/logic/payment/payment.dart';
import 'package:deliveryApp/models/walletModel.dart';
import 'package:deliveryApp/pages/bank_payment_screen.dart';
import 'package:deliveryApp/pages/pos_payment_method.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final Map data;
  final String userWalletAmount;
  final String amount;
  final File selectedFile;

  const PaymentScreen(
      {Key key,
      this.data,
      this.userWalletAmount,
      this.amount,
      this.selectedFile})
      : super(key: key);
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var loading = false;
  List<PaymentMethod> get paymethod => [
        PaymentMethod(
            showAmount: true,
            title: 'Pay with Wallet',
            imageurl: AssetImages.walletIcon,
            callback: () => payWithWallet(context)),
        PaymentMethod(
            title: 'Pay with card on delivery',
            imageurl: AssetImages.masterCard,
            callback: () => payonPickUp(context)),
        PaymentMethod(
            title: 'Pay with card on pick up',
            imageurl: AssetImages.masterCard,
            callback: () => payBeforDelivery(context)),
        PaymentMethod(
            title: 'Pay with Bank Transfer',
            imageurl: AssetImages.bankTransfer,
            callback: () => bankPayment(context))
      ];

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      isLoading: loading,
      child: ConnectivityWidget(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              'Choose Payment Method',
              style: TextStyle(color: appColor),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 45,
                ),
                Text(
                  'How will you like to pay',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(
                  height: 45,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: paymethod.length,
                      itemBuilder: (context, index) {
                        var data = paymethod[index];
                        return PaymentMethodWidget(
                            callback: data.callback,
                            image: data.imageurl,
                            title: data.title,
                            showAmount: data.showAmount);
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//before delivery
  payonPickUp(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => POSPaymentScreen(
                  value: widget.data,
                  file: widget.selectedFile,
                  onDelivery: false,
                )));
  }
  //bank payment

  bankPayment(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BankPaymentScreen(
                  value: widget.data,
                  file: widget.selectedFile,
                )));
  }

  //pos payment on delivery

  payBeforDelivery(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => POSPaymentScreen(
                  value: widget.data,
                  onDelivery: true,
                  file: widget.selectedFile,
                )));
  }

  //fund wallet of user
  payWithWallet(context) {
    setState(() {
      loading = true;
    });
    Payment()
        .payWithWallet(
            double.parse(widget.amount),
            double.parse(widget.userWalletAmount),
            context,
            widget.data,
            widget.selectedFile)
        .then((value) {
      if (value?.data != null) {
        setState(() {
          loading = false;
        });
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => SuccessOrder(
                  requstCode: value.data['order_code'].toString(),
                )));
      } else {
        setState(() {
          loading = false;
        });
        // paymentAlertDailog(context, success: false);
      }
    });
  }

  paymentCard({String image, title, amount, VoidCallback callback}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: InkWell(
        onTap: callback,
        child: Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Row(
              children: <Widget>[
                Image.asset(image),
                SizedBox(
                  width: 20,
                ),
                AutoSizeText(
                  title,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                amount == null
                    ? Container()
                    : Text(
                        amount,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      )
              ],
            ),
          ),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.09),
              offset: Offset(4, 4),
              blurRadius: 15,
            ),
          ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
          width: MediaQuery.of(context).size.width * 0.9,
        ),
      ),
    );
  }
}

class PaymentMethod {
  final String imageurl, title;
  final VoidCallback callback;
  final bool showAmount;

  PaymentMethod(
      {this.imageurl, this.callback, this.title, this.showAmount = false});
}

class PaymentMethodWidget extends StatefulWidget {
  final String image, title;
  final VoidCallback callback;
  final bool showAmount;

  const PaymentMethodWidget(
      {Key key, this.image, this.title, this.showAmount = false, this.callback})
      : super(key: key);
  @override
  _PaymentMethodWidgetState createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  String amount;

  getWalletAmount() async {
    if (!mounted) {
      return;
    } else {
      if (widget.showAmount == true) {
        var walletAmount = await getWallet(context);

        setState(() {
          amount = walletAmount.amount;
        });
      }
    }
  }

  @override
  void initState() {
    getWalletAmount();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: InkWell(
        onTap: widget.callback,
        child: Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Row(
              children: <Widget>[
                Image.asset(widget.image),
                SizedBox(
                  width: 20,
                ),
                AutoSizeText(
                  widget.title,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                amount == null
                    ? Container()
                    : Text(
                        amount,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      )
              ],
            ),
          ),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.09),
              offset: Offset(4, 4),
              blurRadius: 15,
            ),
          ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
          width: MediaQuery.of(context).size.width * 0.9,
        ),
      ),
    );
  }
}
