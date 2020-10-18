import 'package:deliveryApp/custom_ui/custom_card.dart';
import 'package:deliveryApp/http_request.dart';
import 'package:deliveryApp/logic/authentication/register_newuser.dart';
import 'package:deliveryApp/models/walletModel.dart';
import 'package:deliveryApp/pages/fund_wallet_screen.dart';
import 'package:deliveryApp/pages/set_address_screean.dart';
import 'package:deliveryApp/pref/localized_user_data.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:deliveryApp/utils/greatings.dart';
import 'package:deliveryApp/utils/responsiveWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class Dashboard extends StatefulWidget {
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        retriveUserData().then((value) => print(value));
        // logoutUser();
      }),
      body: ResponsiveWidget(builder: (context, info) {
        var isSmall = info.deviceType == DeviceScreenType.XMobile;
        return Builder(builder: (context) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                leading: Container(),
                backgroundColor: Color.fromRGBO(229, 229, 229, 1),
                expandedHeight: isSmall
                    ? MediaQuery.of(context).size.height * 0.7
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
                                future:  retriveUserData(),
                                builder: (context, snapshot) {
                                  var name = snapshot.data != null? snapshot.data['firstname']:'';
                                  return Text(
                                    'Hi ${name?? ''}',
                                    style: TextStyle(
                                        color: appColor,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w500),
                                  );
                                }
                              ),
                              Text(
                                greetingMessage(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                          Icon(Icons.notifications)
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
                                  builder: (context) => FundWalletScreen()));
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Recent Order',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'View All',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    OrderCard(),
                    OrderCard(),
                    OrderCard(),
                    OrderCard(),
                    OrderCard(),
                    OrderCard()
                  ],
                ),
              ),
            ],
          );
        });
      }),
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
                  image: DecorationImage(
                      image: AssetImage(
                        AssetImages.sendPackage,
                      ),
                      fit: BoxFit.cover)),
            ),
            Positioned.fill(
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Send and Receive Packages',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      );
    });
  }
}
