import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button(
      {required this.buttonText,
      required this.onPressed,
      this.isCompressed = false});
  /*
    Text displayed on the [TextButton]
  */
  final String buttonText;
  /*
    Behaviour of [TextButton]'s onPressed
  */
  final Function() onPressed;
  /*
    Boolean which stores whether button is of smaller width
  */
  final bool isCompressed;

  @override
  Widget build(BuildContext context) {
    double compressedWidth = MediaQuery.of(context).size.width * 0.4;
    return Container(
      width: isCompressed ? compressedWidth : double.infinity,
      height: 50.0,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20),
        ),
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xff2FC4B2)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
      ),
    );
  }
}
