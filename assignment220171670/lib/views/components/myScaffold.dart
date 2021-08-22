import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './bottomBar.dart';

class MyScaffold extends StatefulWidget {
  MyScaffold({
    Key? key,
    this.setTitle = false,
    this.bottomBar = false,
    this.title = "Flutter App Page",
    required this.child,
    this.settingsChild,
    this.backButton = true,
  }) : super(key: key);

  /*
    Title to be displayed on [AppBar] of the screen if [setTitle] is true
  */
  final String title;
  /*
    Stores boolean whether to display the [AppBar] and Title
  */
  final bool setTitle;
  /*
    Stores boolean whether to display [BottomBar]
  */
  final bool bottomBar;
  /*
    child Widget to be displayed when home button is pressed or when single child is present.
  */
  final Widget child;
  /*
    child Widget to be displayed when settings button is pressed.
  */
  final Widget? settingsChild;
  /*
    Stores boolean whether to display the BackButton when AppBar (i.e. [setTitle]) is enabled
  */
  final bool backButton;

  @override
  _MyScaffoldState createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  bool home = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: widget.setTitle
            ? PreferredSize(
                preferredSize:
                    Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
                child: AppBar(
                    automaticallyImplyLeading: widget.backButton,
                    backgroundColor: Color(0xff2FC4B2),
                    title: widget.title != "Flutter App Page"
                        ? Center(
                            child: Text(
                              widget.title,
                            ),
                          )
                        : null),
              )
            : null,
        body: home ? widget.child : widget.settingsChild,
        bottomNavigationBar: widget.bottomBar
            ? BottomBar(
                onHomePress: () => {
                  setState(() {
                    home = true;
                  })
                },
                onSettingsPress: () => {
                  setState(() {
                    home = false;
                  })
                },
              )
            : null,
      ),
    );
  }
}
