import 'package:deliveryApp/custom_ui/custom_button.dart';
import 'package:deliveryApp/models/walletModel.dart';
import 'package:deliveryApp/pages/profile/edit_profile_screen.dart';
import 'package:deliveryApp/pages/profile/orders_screen.dart';
import 'package:deliveryApp/pref/localized_user_data.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileViewScreen extends StatefulWidget {
  @override
  _ProfileViewScreenState createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  Map user = {};
  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    if (!mounted) {
      return;
    }
    var userData = await retriveUserData();
    setState(() {
      user = userData;
    });
    print(user);
  }

  launchURL(String phone) async {
    var url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: whiteColor,
        title: Text(
          'Profile',
          style: TextStyle(color: appColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                child: Lottie.asset(
                  AssetImages.happyUser,
                  frameRate: FrameRate.max,
                  reverse: true,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(4, 4),
                          blurRadius: 15,
                          color: Color.fromRGBO(0, 0, 0, 0.18))
                    ],
                    shape: BoxShape.circle),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                user['firstname'] ?? '',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                user['phone'] ?? '',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.8)),
              ),
              Text(
                user['email'] ?? '',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey),
              ),
              WalletWidget(
                title: 'Wallet',
                icon: AssetImages.userwallet,
              ),
              dividerLisTile(
                title: 'Order',
                callback: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OrderScreen()));
                },
                icon: AssetImages.order,
              ),
              dividerLisTile(
                callback: () {
                  contactUsDialog();
                },
                title: 'Contact Us',
                icon: AssetImages.contactuse,
              ),
              dividerLisTile(
                  title: 'Log out',
                  icon: AssetImages.logOut,
                  callback: () => logOutDialog()),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                title: 'Edit Profile',
                callback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreenScreen()));
                },
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  logOutDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => new CupertinoAlertDialog(
                title: new Text(
                  "Info",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                content: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Do you want to log out',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                actions: [
                  CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      isDefaultAction: true,
                      child: new Text("Close")),
                  CupertinoDialogAction(
                      onPressed: () {
                        logoutUser(context);
                      },
                      child: new Text("Log out")),
                ]));
  }

  contactUsDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => new CupertinoAlertDialog(
                title: new Text(
                  "Talk to us today",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                ),
                content: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      '+2349034081322',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                actions: [
                  CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      isDefaultAction: true,
                      child: new Text("Close")),
                  CupertinoDialogAction(
                      onPressed: () => launchURL('08105059613'),
                      child: new Text("Call")),
                ]));
  }

  dividerLisTile({title, icon, VoidCallback callback}) => Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: InkWell(
          onTap: callback,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: ListTile(
                  leading: Image.asset(icon),
                  title: Text(
                    title,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              Divider(
                height: 0.1,
                color: Colors.black.withOpacity(0.2),
              )
            ],
          ),
        ),
      );
}

class WalletWidget extends StatefulWidget {
  final String amount, title, icon;
  final VoidCallback callback;

  const WalletWidget(
      {Key key, this.amount, this.callback, this.title, this.icon})
      : super(key: key);
  @override
  _WalletWidgetState createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
  String amount;

  @override
  void initState() {
    getWalletAmount();
    super.initState();
  }

  getWalletAmount() async {
    var walletAmount = await getWallet(context);

    setState(() {
      amount = walletAmount.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: InkWell(
        onTap: widget.callback,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: ListTile(
                leading: Image.asset(widget.icon),
                title: Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                trailing: amount != null
                    ? Text(
                        'N $amount',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey),
                      )
                    : null,
              ),
            ),
            Divider(
              height: 0.1,
              color: Colors.black.withOpacity(0.2),
            )
          ],
        ),
      ),
    );
  }
}
