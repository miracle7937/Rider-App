import 'package:deliveryApp/custom_ui/custom_button.dart';
import 'package:deliveryApp/pages/profile/edit_profile_screen.dart';
import 'package:deliveryApp/pages/profile/orders_screen.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileViewScreen extends StatefulWidget {
  @override
  _ProfileViewScreenState createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            // Container(
            //   height: 50,
            //   width: 50,
            //   child:  CachedNetworkImage(
            //     imageUrl: AssetImages.userImage,
            //     placeholder: (context, url) => CircularProgressIndicator(),
            //     errorWidget: (context, url, error) => Icon(Icons.error),
            //   ),
            //   decoration: BoxDecoration(shape: BoxShape.circle),
            // )
            Container(
              width: 100,
              height: 100,
              child: Image.asset(
                AssetImages.userImage,
                fit: BoxFit.cover,
              ),
              decoration: BoxDecoration(shape: BoxShape.circle),
            ),
            Text(
              'Adejimi  Tolulope ',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              '08105059613',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.8)),
            ),
            Text(
              'toluadejimi@gmail.com ',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey),
            ),

            dividerLisTile(
                title: 'Wallet',
                icon: AssetImages.userwallet,
                amount: 'N 200.00'),
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
              title: 'LogOut',
              icon: AssetImages.logOut,
            ),
            Spacer(),
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
    );
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
                      '08105059613',
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
                      child: new Text("Call")),
                  CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      isDefaultAction: true,
                      child: new Text("Close")),
                ]));
  }

  dividerLisTile({String amount, title, icon, VoidCallback callback}) =>
      Padding(
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
                  trailing: amount != null
                      ? Text(
                          'N 200.00',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey),
                        )
                      : null,
                ),
              ),
              Divider(
                color: Colors.black,
              )
            ],
          ),
        ),
      );
}
