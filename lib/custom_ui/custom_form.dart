import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatefulWidget {
  final String title, hinText, errorText;
  final TextInputType keyboardType;
  final InputDecoration decoration;
  final TextStyle titleStyle, inputStyle;
  final bool shrinkBottom;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) validator, onFieldSubmitted;
  final Function(String) onChange;

  final Color color;
  final bool passwords;
  const CustomTextForm(
      {Key key,
      this.passwords = false,
      this.onChange,
      this.controller,
      this.onFieldSubmitted,
      this.validator,
      this.focusNode,
      this.decoration,
      this.shrinkBottom = false,
      this.titleStyle,
      this.inputStyle,
      this.title,
      this.hinText,
      this.errorText,
      this.keyboardType = TextInputType.text,
      this.color})
      : super(key: key);

  @override
  _CustomTextFormState createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        widget.title != null
            ? Text(
                widget.title,
                style: widget.titleStyle,
              )
            : Container(),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: widget.color,
          ),
          child: TextFormField(
            onChanged: widget.onChange,
            obscureText: widget.passwords ? showPassword : false,
            validator: widget.validator,
            onFieldSubmitted: widget.onFieldSubmitted,
            focusNode: widget.focusNode,
            controller: widget.controller,
            cursorColor: greenColor,
            style: widget.inputStyle,
            keyboardType: this.widget.keyboardType,
            decoration: widget.decoration ??
                InputDecoration(
                  suffix: widget.passwords
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          child: showPassword
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility))
                      : null,
                  errorText: widget.errorText,
                  hintText: widget.hinText,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: greyColor)),
                  focusColor: appColor,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: appColor, width: 2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: appColor,
                      )),
                ),
          ),
        ),
        this.widget.shrinkBottom == true ? SizedBox() : SizedBox(height: 20),
      ],
    );
  }
}

class CustomDropDowm extends StatefulWidget {
  final String title;
  final Function(String) onChange;

  const CustomDropDowm({Key key, this.title, this.onChange}) : super(key: key);
  @override
  _CustomDropDowmState createState() => _CustomDropDowmState();
}

class _CustomDropDowmState extends State<CustomDropDowm> {
  final List<ListItem> _dropdownItems = [
    ListItem(1, "0-10kg"),
    ListItem(2, "10-20kg"),
    ListItem(3, "20-50kg"),
  ];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;

  ListItem _selectedItem;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title != null
            ? Text(
                widget.title,
              )
            : Container(),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 150,
          height: 45,
          child: Center(
            child: DropdownButton<ListItem>(
                value: _selectedItem,
                items: _dropdownMenuItems,
                onChanged: (value) {
                  widget.onChange(value.name);
                  setState(() {
                    _selectedItem = value;
                  });
                }),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1)),
        ),
      ],
    );
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
