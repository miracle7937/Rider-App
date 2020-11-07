import 'package:deliveryApp/models/orderModel.dart';
import 'package:deliveryApp/pages/dashboard.dart';
import 'package:deliveryApp/pages/profile/orders_screen.dart';
import 'package:deliveryApp/pages/profile/profile_view.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;
  List<OrderModel> orders = [];

  List<Widget> get widgetOptions => <Widget>[
        Dashboard(
          orders: orders,
        ),
        OrderScreen(),
        ProfileViewScreen()
      ];

  getListOfOrder(BuildContext context) {
    getOrder(context).then((value) {
      print(value);
      setState(() {
        orders = value;
      });
    });
  }

  @override
  void initState() {
    getListOfOrder(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      body: widgetOptions[_index],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white.withOpacity(0.5),
        selectedItemColor: Colors.white,
        backgroundColor: appColor,
        onTap: (newIndex) => setState(() => _index = newIndex),
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), title: Text("Orders")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Users")),
        ],
      ),
    );
  }

  placeHolder(index, image) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
                color: _index == index ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(12)),
            child: Image.asset(image)),
      );
}
