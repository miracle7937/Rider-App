import 'package:deliveryApp/http_request.dart';
import 'package:deliveryApp/logic/authentication/register_newuser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class WalletModel {
  final String amount;

  WalletModel({this.amount});
  factory WalletModel.fromJson(Map value) {
    return WalletModel(amount: value['data']['amount']);
  }
}

Future<WalletModel> getWallet(BuildContext context) async {
  var data = await UserWallet(ServerData(), '/wallet', context).getNO();
  var wallet = WalletModel.fromJson(data.data);
  return wallet;
}

deducetWallet(BuildContext context, {String amount}) async {
  var result = await UserWallet(ServerData(), '/wallet/deduct', context,
      data: {"amount": amount}).putNO();
  return result.data;
}
