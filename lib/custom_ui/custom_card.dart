import 'package:deliveryApp/models/orderModel.dart';
import 'package:deliveryApp/models/walletModel.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:deliveryApp/utils/responsiveWidget.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final bool forWallet;
  final VoidCallback topUp;

  const CustomCard({Key key, this.forWallet = false, this.topUp})
      : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  String amount;
  getWalletAmount() async {
    if (!mounted) {
      return;
    } else {
      var walletAmount = await getWallet(context);

      setState(() {
        amount = walletAmount.amount;
      });
    }
  }

  @override
  void initState() {
    getWalletAmount();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.forWallet ? null : widget.topUp,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 177,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget.forWallet
                ? Text(
                    'CURRENT ACCOUNT',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )
                : Container(),
            widget.forWallet
                ? SizedBox(
                    height: 20,
                  )
                : SizedBox.shrink(),
            // !widget.forWallet
            //     ? 
                Text(
                    '₦  ${amount ?? ''}',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 30,
                        color: whiteColor),
                  ),
                // : StreamBuilder(
                //     stream: Stream.fromFuture(getWallet(context)),
                //     builder: (context, snapshot) {
                //       return Text(
                //         '₦  ${snapshot.data?.amount ?? ''}',
                //         style: TextStyle(
                //             fontWeight: FontWeight.w300,
                //             fontSize: 30,
                //             color: whiteColor),
                //       );
                //     }),
            SizedBox(
              height: 15,
            ),
            widget.forWallet
                ? Container()
                : InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[topUppButton()],
                    ),
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
      ),
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

class UserOrderCard extends StatelessWidget {
  final OrderModel order;

  const UserOrderCard({Key key, this.order}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, info) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        width: MediaQuery.of(context).size.width * 0.9,
        // height: isSmall
        //     ? MediaQuery.of(context).size.height * 0.2
        //     : MediaQuery.of(context).size.height * 0.15,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      order.pickupAddress,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(140, 140, 140, 1),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      order.deliveryAddress,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(140, 140, 140, 1),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(order.packageTitle),
                  Spacer(),
                  order.rider.isEmpty ? Container() : driverName(order.rider)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(order.receiverFullname),
                  Spacer(),
                  Text(
                    '₦${order.amount}',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(140, 140, 140, 1),
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  placeHolder(Colors.grey, order.orderCode),
                  placeHolder(statusColor(order.status), order.status),
                  Text(order.date)
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
    });
  }

  statusColor(String status) {
    if (status == "Completed") {
      return greenColor;
    } else if (status == "Pending") {
      return orangeColor;
    } else {
      return Colors.red;
    }
  }

  driverName(String driver) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        child: Text(
          driver,
          style: TextStyle(color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
          color: appColor, borderRadius: BorderRadius.circular(12)),
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
    return ResponsiveWidget(builder: (context, info) {
      var isSmall = info.deviceType == DeviceScreenType.XMobile;
      return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: isSmall
            ? MediaQuery.of(context).size.height * 0.26
            : MediaQuery.of(context).size.height * 0.19,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: child,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.4),
            offset: Offset(4, 4),
            blurRadius: 15,
          ),
        ], color: whiteColor, borderRadius: BorderRadius.circular(15)),
      );
    });
  }
}

//amount card

class AmountCard extends StatelessWidget {
  final String amount;

  const AmountCard({Key key, this.amount}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, info) {
      var isSmall = info.deviceType == DeviceScreenType.XMobile;
      return Container(
        height: isSmall
            ? MediaQuery.of(context).size.height * 0.15
            : MediaQuery.of(context).size.height * 0.1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Estimated Price',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total '),
                  Text(
                    '₦ ${amount ?? ''}',
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
    });
  }
}
