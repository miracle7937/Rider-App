import 'package:deliveryApp/static_content/colors.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String title, hinText,errorText;
  final TextInputType keyboardType;
  final InputDecoration decoration;
  final TextStyle titleStyle, inputStyle;
  final bool shrinkBottom;
  final TextEditingController controller;
final FocusNode focusNode;
final Function(String) validator, onFieldSubmitted;
  const CustomTextForm(
      {Key key,
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
      this.keyboardType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        title != null
            ? Text(
                title,
                style: titleStyle,
              )
            : Container(),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          autofocus: true,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
          focusNode: focusNode,
          controller: controller,
          cursorColor: greenColor,
          style: inputStyle,
          keyboardType: this.keyboardType,
          decoration: decoration ??
              InputDecoration(
                errorText: errorText,
                hintText: hinText,
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
        this.shrinkBottom == true ? SizedBox() : SizedBox(height: 20),
      ],
    );
  }
}

class CustomDropDowm extends StatefulWidget {
  @override
  _CustomDropDowmState createState() => _CustomDropDowmState();
}

class _CustomDropDowmState extends State<CustomDropDowm> {
  final List<ListItem> _dropdownItems = [
    ListItem(1, "First Value"),
    ListItem(2, "Second Item"),
    ListItem(3, "Third Item"),
    ListItem(4, "Fourth Item")
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
    return Container(
      width: 150,
      height: 45,
      child: Center(
        child: DropdownButton<ListItem>(
            value: _selectedItem,
            items: _dropdownMenuItems,
            onChanged: (value) {
              setState(() {
                _selectedItem = value;
              });
            }),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), border: Border.all(width: 1)),
    );
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
