import 'package:deliveryApp/http_request.dart';
import 'package:deliveryApp/logic/authentication/register_newuser.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class OrderModel {
  final String deliveryAddress,
      pickupAddress,
      receiverFullname,
      receiverPhone,
      packageTitle,
      packageWeight,
      packageValue,
      status,
      orderCode,
      date,
      amount,
      rider;

  OrderModel(
      {this.deliveryAddress,
      this.rider,
      this.amount,
      this.pickupAddress,
      this.receiverFullname,
      this.receiverPhone,
      this.packageTitle,
      this.packageWeight,
      this.packageValue,
      this.status,
      this.orderCode,
      this.date});

  factory OrderModel.json(Map map) {
    DateTime myDatetime = DateTime.parse(map['created_at']);

    return OrderModel(
        receiverFullname: map['receiver_fullname'] ?? '',
        deliveryAddress: map['delivery_address'] ?? '',
        pickupAddress: map['pickup_address'] ?? '',
        receiverPhone: map['receiver_phone'] ?? '',
        packageTitle: map['package_title'] ?? '',
        packageValue: map['package_value'] ?? '',
        packageWeight: map['package_weight'] ?? '',
        status: map['status'] ?? '',
        orderCode: map['order_code'] ?? '',
        rider: map['rider'] == null ? '' : map['rider']["firstname"],
        amount: map["payment_amount"] ?? '',
        date: DateFormat.yMEd().format(myDatetime));
  }
}

Future<List<OrderModel>> getOrder(BuildContext context) async {
  HttpResponse data = await UserOrder(ServerData(), '/order', context).getNO();

  List orders = data?.data['data'];

  List<OrderModel> listOrders = orders.map((e) => OrderModel.json(e)).toList();
  // var wallet = OrderModel.json(data?.data);
  return listOrders.isNotEmpty ? listOrders : <OrderModel>[];
}

class SearchStream {
  var streamController;
  SearchStream() {
    streamController = BehaviorSubject<List<OrderModel>>();
  }
  Stream<List<OrderModel>> searchOrders(BuildContext context, String query) {
    print(query);
    getOrder(context).then((data) {
      if (query.isNotEmpty) {
        var value = data.where((element) {
          print(element.deliveryAddress.contains(query));
          return (element.deliveryAddress.toLowerCase().contains(query) || element.pickupAddress.toLowerCase().contains(query)  || element.packageTitle.toLowerCase().contains(query) );
        }).toList();
        print(value.length);
        streamController.sink.add(value);
      } else {
        streamController.sink.add(data);
      }
    });

    return streamController.stream;
  }

  dispose() {
    streamController.close();
  }
}

/*






 "delivery_address": "44 Willson road",
            "pickup_address": "25 Berger road",
            "receiver_fullname": "Kingsley Awe",
            "receiver_phone": "08075434345",
            "package_title": "Iphone",
            "package_weight": "0 - 10kg",
            "fragile": "0",
            "package_value": "20000",

"payment_type": "card",
            "payment_amount": "500",
            "status": "Pending",
            "rider_assigned_id": null,
            "accepted": "0",
            "order_code": "0",
            "created_at": "2020-10-16T20:41:04.000000Z",
            "updated_at": "2020-10-16T20:41:04.000000Z",
            "rider": null
 */
