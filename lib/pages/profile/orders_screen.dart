import 'package:deliveryApp/custom_ui/custom_form.dart';
import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Fund Wallet',
            style: TextStyle(color: appColor),
          ),
        ),
        
        
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:35.0),
              child: CustomTextForm(
                hinText: 'Search',
              ),


            ),



          ],
        ),
        );
  }
}


class OrderCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.height*0.9,
      
      
    );
  }
}