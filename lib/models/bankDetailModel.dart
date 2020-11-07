
import 'package:deliveryApp/http_request.dart';
import 'package:deliveryApp/logic/repository.dart';
import 'package:flutter/cupertino.dart';

class BankDetailController {
  final String bankName, accountName, accountNumber, referenceCode;

  BankDetailController(
      {this.bankName,
      this.accountName,
      this.accountNumber,
      this.referenceCode});

  factory BankDetailController.json(Map map) {
    return BankDetailController(
        accountName: map['account_name'],
        accountNumber: map["account_number"],
        bankName: map['bank_name'],
        referenceCode: map['reference_code']);
  }
}

Future<BankDetailController> getBankdetails(BuildContext context) async {
  var data = await Repository(ServerData(), context, '/bank').getNO();
  if (data != null) {
    return BankDetailController.json(data.data['data']);
  } else {
    return null;
  }
}
