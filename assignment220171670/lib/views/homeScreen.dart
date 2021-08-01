import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import './../model/resource/resource.dart';
import './components/button.dart';
import './components/myScaffold.dart';
import './components/circleWithText.dart';
import './../services/track/trackService.dart';
import './../services/serviceLocator.dart';
import '/../controller/trackScreenViewModel.dart';
import '/../controller/settingsScreenViewModel.dart';
import './trackScreen.dart';
import './../services/storage/storageService.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen(
      {Key? key,
      this.DTOresource,
      required this.homeBio,
      required this.isPreviousPageRegister})
      : super(key: key);
  /* 
    Transmission resource passed back on pop.
    Acts like a travelling database.
  */
  final Resource? DTOresource;
  /*
    ID number or name of the valid [Member] who successfully logged in. Displayed in the Greeting.
  */
  final String homeBio;
  /*
    Stores boolean whether previous page was a Registration page. This manages number of pops required to reach initial Login Page.
  */
  final bool isPreviousPageRegister;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String homeBio = "homeBio";

  final _trackService = serviceLocator<TrackService>();

  StorageService _storageService = serviceLocator<StorageService>();

  Timer _timer = Timer(const Duration(milliseconds: 200), () {});

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  Widget build(BuildContext context) {
    var homeBioState =
        Provider.of<SettingsScreenViewModel>(context, listen: false);
    this.homeBio = homeBioState.getHomeBio();

    _timer = Timer(const Duration(milliseconds: 200), () {
      setState(() {});
    });

    return Consumer<TrackScreenViewModel>(
      builder: (context, stateGetter, _) => Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.84,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              showGreeting(context),
              showBody(context, stateGetter),
              showScoreAndTrackButton(context, stateGetter),
              showLogOutButton(context)
            ],
          ),
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

  Widget showGreeting(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "Hi " + homeBio + " !",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35,
            ),
          ),
        ],
      ),
    );
  }

  Widget showBody(BuildContext context, TrackScreenViewModel state) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        color: Color(0x222FC4B2),
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Progress",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.completedAssignments.length.toString() + " / 6",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        "assignments done",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
                CircleWithText(
                  text: _trackService
                          .getPercentage(state.completedAssignments.length)
                          .toString() +
                      " %",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget showOldBody(BuildContext context) {
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
            widget.homeBio,
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

  Widget showScoreAndTrackButton(
      BuildContext context, TrackScreenViewModel state) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.18,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(
              "Your Score",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleWithText(
                text: state.score.toString(),
              ),
              Button(
                buttonText: "TRACK",
                isCompressed: true,
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyScaffold(
                        setTitle: true,
                        backButton: false,
                        bottomBar: true,
                        child: TrackScreen(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget showLogOutButton(BuildContext context) {
    return Button(
      buttonText: "LOG OUT",
      onPressed: () {
        _storageService.saveLoginData(false);
        Navigator.pop(context);
        if (widget.isPreviousPageRegister) {
          Navigator.pop(context);
        }
      },
    );
  }
}
