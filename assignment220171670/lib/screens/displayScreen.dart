import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resource/resource.dart';
import '../components/button.dart';

class DisplayScreen extends StatelessWidget {
  DisplayScreen(
      {Key? key,
      required this.DTOresource,
      required this.idNumber,
      required this.isPreviousPageRegister})
      : super(key: key);
  /* 
    Transmission resource passed back on pop.
    Acts like a travelling database.
  */
  final Resource DTOresource;
  /*
    ID number od the valid [Member] who successfully logged in. Displayed in the Greeting.
  */
  final String idNumber;
  /*
    Stores boolean whether previous page was a Registration page. This manages number of pops required to reach initial Login Page.
  */
  final bool isPreviousPageRegister;

  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.84,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            showHeader(context),
            showBody(context),
            showButton(context),
          ],
        ),
      ),
    );
  }

  Widget showHeader(BuildContext context) {
    return Text(
      "CRUX FLUTTER SUMMER GROUP",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.w800,
        color: Color(0xff2FC4B2),
      ),
    );
  }

  Widget showBody(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "welcomes you",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            idNumber,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 30,
            ),
          ),
          Text(
            "Have a great journey ahead !!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }

  Widget showButton(BuildContext context) {
    return Button(
      buttonText: "LOG OUT",
      onPressed: () {
        Navigator.pop(context, DTOresource);
        if (isPreviousPageRegister) {
          Navigator.pop(context, DTOresource);
        }
      },
    );
  }
}
