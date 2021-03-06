import 'dart:core';
import 'dart:async';
import 'package:deliveryApp/static_content/Images.dart';
import 'package:deliveryApp/utils/responsiveWidget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MySplashScreen extends StatefulWidget {
  final int seconds;
  final Text title;
  final Color backgroundColor;
  final TextStyle styleTextUnderTheLoader;
  final dynamic navigateAfterSeconds;
  final double photoSize;
  final dynamic onClick;
  final Color loaderColor;
  final Widget image;
  final Text loadingText;
  final ImageProvider imageBackground;
  final Gradient gradientBackground;
  MySplashScreen(
      {this.loaderColor,
      @required this.seconds,
      this.photoSize,
      this.onClick,
      this.navigateAfterSeconds,
      this.title = const Text(''),
      this.backgroundColor = Colors.white,
      this.styleTextUnderTheLoader = const TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
      this.image,
      this.loadingText = const Text(""),
      this.imageBackground,
      this.gradientBackground});

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: widget.seconds), () {
      if (widget.navigateAfterSeconds is String) {
        // It's fairly safe to assume this is using the in-built material
        // named route component
        Navigator.of(context).pushReplacementNamed(widget.navigateAfterSeconds);
      } else if (widget.navigateAfterSeconds is Widget) {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => widget.navigateAfterSeconds));
      } else {
        throw new ArgumentError(
            'widget.navigateAfterSeconds must either be a String or Widget');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: ResponsiveWidget(builder: (context, devInfo) {

        return new InkWell(
          onTap: widget.onClick,
          child: new Stack(
            fit: StackFit.expand,
            children: <Widget>[
              new Container(
                decoration: new BoxDecoration(
                  image: widget.imageBackground == null
                      ? null
                      : new DecorationImage(
                          fit: BoxFit.cover,
                          image: widget.imageBackground,
                        ),
                  gradient: widget.gradientBackground,
                  color: widget.backgroundColor,
                ),
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    flex: 3,
                    child: new Container(
                        child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: new Container(child: widget.image),
                          radius: widget.photoSize,
                        ),
                        Container(
                          
                          child: widget.title),
                          SizedBox(
                            height: 40,
                          ),
                          CircularProgressIndicator(
                          strokeWidth: 1,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              widget.loaderColor),
                        ),
                      ],
                    )),
                  ),
                  // Expanded(
                  //   flex: 1,
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: <Widget>[
                        
                  //       Padding(
                  //         padding: const EdgeInsets.only(top: 20.0),
                  //       ),
                  //       widget.loadingText
                  //     ],
                  //   ),
                  // ),
                  Lottie.asset(AssetImages.courier, fit:BoxFit.cover),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
