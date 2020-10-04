import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const LoadingWidget({Key key, this.isLoading = false, this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        isLoading
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: SizedBox(
                          height: 100,
                          width: 100,
                          child:
                              Lottie.asset('assets/images/8774-loading.json')),
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}
