import 'package:deliveryApp/http_request.dart';
import 'package:deliveryApp/logic/authentication/register_newuser.dart';
import 'package:flutter/cupertino.dart';

class RateModel {
  final int rate;

  RateModel({this.rate});
  factory RateModel.fromJson(Map value) {
    return RateModel(rate: int.parse(value['data']['rate']));
  }
}

Future<RateModel> getRate(BuildContext context) async {
  var data = await TFRate(ServerData(), '/rate', context).getNO();
  var rate = RateModel.fromJson(data.data);
  return rate;
}
