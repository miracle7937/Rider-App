import 'package:deliveryApp/custom_ui/custom_button.dart';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:flutter/material.dart';

class CustomAuthWidget extends StatelessWidget {
  final VoidCallback callback;
  final String btnText;
  final String title, subTitle;
  final Widget form;

  const CustomAuthWidget(
      {Key key,
      this.callback,
      this.btnText,
      this.title,
      this.subTitle,
      this.form})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(50)),
                color: Colors.white),
            height: MediaQuery.of(context).size.height * 0.4,
            child: Image.asset(CryptoImage.authbg),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20), child: form),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          CustomButton(
            textStyle: TextStyle(color: Colors.black, fontSize: 16),
            title: btnText,
            color: Colors.white,
            callback: callback,
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
