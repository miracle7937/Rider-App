import 'package:deliveryApp/custom_ui/custom_card.dart';
import 'package:deliveryApp/pages/set_address_screean.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Hi Tolupe',
                        style: TextStyle(
                            color: appColor,
                            fontSize: 34,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Good morning',
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
            Center(child: CustomCard()),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SetAddressScreen()));
              },
              child: makeRequest(context)),
            SizedBox(
              height: 15,
            ),
            Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Recent Order'),
                  Text('View All')
                ],
              ),
            ),
            Expanded(child: ListView(children: <Widget>[
              OrderCard(),
              OrderCard(),
              OrderCard(),
              OrderCard()
            ],))
          ],
        ),
      ),
    );
  }

  SizedBox makeRequest(BuildContext context) {
    return SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            CryptoImage.sendPackage,
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
  }
}
