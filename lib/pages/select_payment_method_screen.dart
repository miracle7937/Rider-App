import 'package:deliveryApp/pages/bank_payment_screen.dart';
import 'package:deliveryApp/pages/fund_wallet_screen.dart';
import 'package:deliveryApp/pages/pos_payment_method.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<PaymentMethod> get paymethod => [
        PaymentMethod(
            amount: ' ₦ 12000',
            title: 'Pay with Wallet',
            imageurl: CryptoImage.walletIcon,
            callback: () => fundWallet(context)),
        PaymentMethod(
            title: 'Pay with card on delivery',
            imageurl: CryptoImage.masterCard,
            callback: () => posPayment(context)),
        PaymentMethod(
          title: 'Pay with card on pick up',
          imageurl: CryptoImage.masterCard,
        ),
        PaymentMethod(
            title: 'Pay with Bank Transfer',
            imageurl: CryptoImage.bankTransfer,
            callback: () => bankPayment(context))
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Text(
              'How will you like to pay',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: paymethod.length,
                  itemBuilder: (context, index) {
                    var data = paymethod[index];
                    return paymentCard(
                        callback: data.callback,
                        image: data.imageurl,
                        title: data.title,
                        amount: data.amount);
                  }),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
  //bank payment

  bankPayment(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BankPaymentScreen()));
  }

  //pos payment on delivery

  posPayment(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => POSPaymentScreen()));
  }

  //fund wallet of user
  fundWallet(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FundWalletScreen()));
  }

  paymentCard({String image, title, amount, VoidCallback callback}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
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
                  width: 30,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
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
  final String imageurl, title, amount;
  final VoidCallback callback;

  PaymentMethod({this.imageurl, this.callback, this.title, this.amount});
}