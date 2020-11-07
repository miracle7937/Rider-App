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
  Future<HttpResponse> payWithCard(BuildContext context, Map data, File file);
  Future<HttpResponse> payWithWallet(
      num amount, num wallet, BuildContext context, Map data, File file);
  Future<HttpResponse> payWithBankTransfer(BuildContext context, Map data, File file);
}

class Payment extends PaymentRepo {
  @override
  Future<HttpResponse> payWithBankTransfer(BuildContext context, Map userRequestData, File file) async{
   userRequestData['payment_type'] = 'Wallet';
    var value = await DeductWallet(ServerData(), '/order', context,
                data:  userRequestData, file: file)
            .makeRequest();

        return value;
    
  }

  @override
  Future<HttpResponse> payWithCard(BuildContext context, Map userRequestData, File file) async{

    var value = await DeductWallet(ServerData(), '/order', context,
                data:  userRequestData, file: file)
            .makeRequest();

        return value;
    
          
  }

 

  @override
  Future<HttpResponse> payWithWallet(amount, wallet, context, userRequestData, file) async {
 
    userRequestData['payment_type'] = 'Wallet';
    if (wallet > amount) {
      var data = await deducetWallet(context, amount: amount.toString());
      if (data != null) {
        ///post data
        var value = await DeductWallet(ServerData(), '/order', context,
                data: userRequestData, file: file)
            .makeRequest();

        return value;
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
