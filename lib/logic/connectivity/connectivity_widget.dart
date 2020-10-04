import 'package:deliveryApp/logic/connectivity/check_connectivity.dart';
import 'package:deliveryApp/pages/user_route_checks/network_pages.dart';
import 'package:flutter/material.dart';

class ConnectivityWidget extends StatelessWidget {
  final Widget child;

  const ConnectivityWidget({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: checkConnection(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return child;
          } else {
            return NoNetwork();
          }
        });
  }
}
