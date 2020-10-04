import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  final bool loading;
  final Color color;
  final TextStyle textStyle;

  const CustomButton({
    Key key,
    @required this.title,
    this.callback,
    this.loading = false,
    this.color,
    this.textStyle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : callback,
      child: Container(
        height: 53,
        width: 300,
        decoration: BoxDecoration(
            color: color == null ? Color.fromRGBO(2, 35, 122, 1) : color,
            borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: !loading
              ? Text(title,
                  style: textStyle == null
                      ? TextStyle(color: Colors.white, fontSize: 16)
                      : textStyle)
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red)),
                ),
        ),
      ),
    );
  }
}
