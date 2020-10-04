import 'package:flutter/material.dart';

errorSnackBar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(new SnackBar(
    backgroundColor: Colors.red,
    content: Text(
      message.toString(),
      style: TextStyle(color: Colors.white),
    ),
  ));
}

successSnackBar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(new SnackBar(
    backgroundColor: Colors.green,
    content: Text(
      message.toString(),
      style: TextStyle(color: Colors.white),
    ),
  ));
}
