import 'package:deliveryApp/custom_ui/custom_card.dart';
import 'package:deliveryApp/logic/connectivity/connectivity_widget.dart';

import 'package:deliveryApp/models/orderModel.dart';

import 'package:deliveryApp/pages/fund_wallet_screen.dart';
import 'package:deliveryApp/pages/profile/orders_screen.dart';
import 'package:deliveryApp/pages/set_address_screean.dart';
import 'package:deliveryApp/pref/localized_user_data.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:deliveryApp/utils/greatings.dart';
import 'package:deliveryApp/utils/responsiveWidget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Dashboard extends StatefulWidget {
  final List<OrderModel> orders;

  const Dashboard({Key key, this.orders}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidget(
      child: Scaffold(
        backgroundColor: Colors.white,
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   retriveUserData().then((value) => print(value));
        //   // logoutUser();
        // }),
        body: ResponsiveWidget(builder: (context, info) {
          var isSmall = info.deviceType == DeviceScreenType.XMobile;
          return Builder(builder: (context) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  leading: Container(),
                  backgroundColor: Colors.white,
                  expandedHeight: isSmall
                      ? MediaQuery.of(context).size.height * 0.73
                      : MediaQuery.of(context).size.height * 0.55,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                FutureBuilder(
                                    future: retriveUserData(),
                                    builder: (context, snapshot) {
                                      var name = snapshot.data != null
                                          ? snapshot.data['firstname']
                                          : '';
                                      return Text(
                                        'Hi ${name ?? ''}',
                                        style: TextStyle(
                                            color: appColor,
                                            fontSize: 40,
                                            fontWeight: FontWeight.w500),
                                      );
                                    }),
                                Text(
                                  greetingMessage(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            // Icon(Icons.notifications)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: CustomCard(
                          topUp: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FundWalletScreen(
                                          forDashboard: true,
                                        )));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SetAddressScreen()));
                          },
                          child: makeRequest(context)),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  )),
                ),
                SliverFixedExtentList(
                  itemExtent: 20,
                  delegate: SliverChildListDelegate([
                    widget.orders.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Recent Order',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OrderScreen()));
                                  },
                                  child: Text(
                                    'View All',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                  ]),
                ),
                widget.orders.isNotEmpty
                    ? SliverList(
                        delegate: SliverChildListDelegate([
                        Column(
                            children: (widget.orders.isNotEmpty ||
                                    widget.orders != null)
                                ? (widget.orders.reversed
                                    .toList()
                                    .map((value) => UserOrderCard(order: value))
                                    .toList())
                                : [
                                    noValueWidget(
                                      Text(
                                        'Your have no order',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ]),
                      ]))
                    : SliverToBoxAdapter(
                        child: Column(
                        children: [
                          Text(
                            'No recent  order',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Lottie.asset(AssetImages.emptyOrder,
                                  frameRate: FrameRate.max,
                                  reverse: true,
                                  repeat: false)),
                        ],
                      )),
                //   child: noValueWidget(
                //   Text(
                //     'Your have no order',
                //     style: TextStyle(
                //         fontSize: 17, fontWeight: FontWeight.bold),
                //   ),
                // )
              ],
            );
          });
        }),
      ),
    );
  }

  noValueWidget(Widget child) {
    return Container(
      child: Center(child: child),
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
    );
  }

  makeRequest(BuildContext context) {
    return ResponsiveWidget(builder: (context, info) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Stack(
          children: <Widget>[
            Container(
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: Image(
                      image: AssetImage(
                        AssetImages.sendAndReceive,
                      ),
                    ).image,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(4, 4),
                        blurRadius: 15,
                        color: Color.fromRGBO(0, 0, 0, 0.19))
                  ]),
            ),
            // Positioned.fill(
            //   child: Align(
            //       alignment: Alignment.center,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Image(
            //             image: AssetImage(
            //               AssetImages.sendAndReceive,
            //             ),
            //           ),
            //           SizedBox(
            //             width: 20,
            //           ),
            //           Text(
            //             'Send and Receive',
            //             style: TextStyle(
            //                 fontSize: 20,
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.bold),
            //           ),
            //         ],
            //       )),
            // )
          ],
        ),
      );
    });
  }
}
