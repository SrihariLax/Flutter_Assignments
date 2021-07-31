import 'package:flutter/material.dart';

class CircleWithText extends StatelessWidget {
  CircleWithText({Key? key, required this.text}) : super(key: key);

/*
  Text to be displayed within the [Circle]
*/
  final String text;

  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      decoration:
          BoxDecoration(color: Color(0xff2FC4B2), shape: BoxShape.circle),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
