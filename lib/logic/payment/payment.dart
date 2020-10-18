import 'dart:io';

import 'package:deliveryApp/http_request.dart';
import 'package:deliveryApp/logic/authentication/register_newuser.dart';
import 'package:deliveryApp/models/walletModel.dart';
import 'package:deliveryApp/pages/fund_wallet_screen.dart';
import 'package:flutter/material.dart';

enum ChoosePayment {
  payWithWallet,
  payWithCard,
  payWithCardOnPickUp,
  payWithBankTransfer
}

abstract class PaymentRepo {
  void payWithCard(Map data);
  void payWithWallet(
      num amount, num wallet, BuildContext context, Map data, File file);
  void payWithCardOnPickUp(Map data);
  void payWithBankTransfer(Map data);
}

class Payment extends PaymentRepo {
  @override
  void payWithBankTransfer(data) {}

  @override
  void payWithCard(data) {
    //to check if the user have enough
  }

  @override
  void payWithCardOnPickUp(data) {}

  @override
  void payWithWallet(amount, wallet, context, userRequestData, file) async {
    // var data = await getWallet(context);
    if (wallet > amount) {
      var data = await deducetWallet(context, amount: amount.toString());
      if (data != null) {
        ///post data
        DeductWallet(ServerData(), '/order', context, data: userRequestData, file: file)
            .makeRequest()
            .then((value) {
          print(value);
        });
      }
    } else {
// navigator to  toup page
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FundWalletScreen()));
    }
  }
}

//check if the user have enough to cover the expenxis
//the deduct before post or direct to topup
