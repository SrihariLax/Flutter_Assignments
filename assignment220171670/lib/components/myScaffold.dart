import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  MyScaffold(
      {Key? key,
      this.setTitle = false,
      this.title = "Flutter App Page",
      this.child,
      this.backButton = true})
      : super(key: key);

  /*
    Title to be displayed on [AppBar] of the screen if [setTitle] is true
  */
  final String title;
  /*
    Stores boolean whether to display the [AppBar] and Title
  */
  final bool setTitle;
  /*
    child Widget.
  */
  final Widget? child;

  /*
    Stores boolean whether to display the BackButton when AppBar (i.e. [setTitle]) is enabled
  */
  final bool backButton;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: setTitle
            ? PreferredSize(
                preferredSize:
                    Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
                child: AppBar(
                  automaticallyImplyLeading: backButton,
                  backgroundColor: Color(0xff2FC4B2),
                  title: Center(
                    child: Text(
                      title,
                    ),
                  ),
                ),
              )
            : null,
        body: child,
      ),
    );
  }
}
