import 'package:flutter/material.dart';

/*
  Groups together a TextField and its Label on top.
*/
class TextboxWithLabel extends StatelessWidget {
  TextboxWithLabel(
      {Key? key,
      required this.label,
      this.hintText,
      this.obscureText = false,
      this.errorText,
      this.onTextChanged})
      : super(key: key);

  /*
    label displayed on top of the [TextField]
  */
  final String label;
  /*
    placeholder displayed in the [TextField]
  */
  final String? hintText;
  /*
    Stores boolean whether it is a password field and requires hidden text (with dots).
  */
  final bool obscureText;
  /*
    String to be displayed on error. This is returned by the validator.
  */
  final String? errorText;
  /*
    onTextChanged for the [TextField]
  */
  final Function(String)? onTextChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            child: TextField(
              onChanged: onTextChanged,
              cursorHeight: 25.0,
              obscureText: obscureText,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.red, width: 1.0),
                ),
                disabledBorder: InputBorder.none,
                errorText: errorText,
                contentPadding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                filled: true,
                fillColor: Color(0xffeeeeee),
                hintText: hintText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
