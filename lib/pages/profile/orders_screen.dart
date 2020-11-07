import 'package:deliveryApp/custom_ui/custom_card.dart';
import 'package:deliveryApp/custom_ui/custom_form.dart';
import 'package:deliveryApp/logic/connectivity/connectivity_widget.dart';
import 'package:deliveryApp/models/orderModel.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final textForm = TextEditingController();
  String query = '';
  @override
  Widget build(BuildContext context) {
    var searchStream = SearchStream();
    return ConnectivityWidget(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Orders',
            style: TextStyle(color: appColor),
          ),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: CustomTextForm(
                onChange: (value) {
                  setState(() {
                    query = value;
                  });
                },
                hinText: 'Search',
              ),
            ),
            Expanded(
              child: StreamBuilder<List<OrderModel>>(
                  stream:
                      searchStream.searchOrders(context, query.toLowerCase()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final items = snapshot.data;
                      if (items.length > 0) {
                        return ListView.builder(
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context, i) {
                              var value = snapshot.data.reversed.toList();
                              return UserOrderCard(order: value[i]);
                            });
                      } else {
                        return EmptyCards();
                      }
                    } else if (snapshot.error != null) {
                      print('${snapshot.error}');
                      return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Lottie.asset(AssetImages.error_list,
                              frameRate: FrameRate.max,
                              reverse: true,
                              repeat: false));
                    } else {
                      return SizedBox(child: Lottie.asset(AssetImages.loading));
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class EmptyCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        children: [
          Text(
            'No Order',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Lottie.asset(AssetImages.emptyOrder,
                  frameRate: FrameRate.max, reverse: true, repeat: false)),
        ],
      )),
    );
  }
}
