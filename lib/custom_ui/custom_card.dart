import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
final bool forWallet;

  const CustomCard({Key key, this.forWallet=false}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 177,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
              forWallet?Text('CURRENT ACCOUNT', style: TextStyle(
                fontSize: 14, color: Colors.white
              ),):Container(),
                forWallet? SizedBox(
                  height: 20,
                ):SizedBox.shrink(),
          Text(
            '₦  200.00',
            style: TextStyle(
                fontWeight: FontWeight.w300, fontSize: 30, color: whiteColor),
          ),
          SizedBox(
            height: 15,
          ),
        forWallet? Container(): Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[topUppButton()],
          )
        ],
      ),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.5),
          offset: Offset(4, 4),
          blurRadius: 15,
        ),
      ], color: appColor, borderRadius: BorderRadius.circular(12)),
    );
  }

  topUppButton() => Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text('Top Up Wallet'),
        ),
      );
}

//order card

class OrderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Lekki Phase 1',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(140, 140, 140, 1),
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  'Oshodi, Lagos',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(140, 140, 140, 1),
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  '₦  1500',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(140, 140, 140, 1),
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Text('1:00pm'), Text('12:00pm'), Text('')],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                placeHolder(Colors.grey, 'ORD2333'),
                placeHolder(greenColor, 'completed'),
                Text('Today')
              ],
            )
          ],
        ),
      ),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          offset: Offset(4, 4),
          blurRadius: 15,
        ),
      ], color: whiteColor, borderRadius: BorderRadius.circular(12)),
    );
  }

  placeHolder(Color color, String text) => Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(10)),
          ),
        ],
      );
}

//form card
class FormCard extends StatelessWidget {
  final Widget child;

  const FormCard({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.8,
      height: MediaQuery.of(context).size.height * 0.19,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: child,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          offset: Offset(4, 4),
          blurRadius: 15,
        ),
      ], color: whiteColor, borderRadius: BorderRadius.circular(15)),
    );
  }
}


//amount card

class AmountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Estimated Price',
                style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total '),
                  Text(
                    '₦ 1200.00',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            color: greyColor, borderRadius: BorderRadius.circular(8)),
      );
  }
}