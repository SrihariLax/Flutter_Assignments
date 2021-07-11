import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
          width:double.infinity,
          child: MyHomePage(title: 'Assignment 1 Home Page')),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(
          title
        ),
      ),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Container(
            width:double.infinity,
            height:70.0,
            margin: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
            child: RaisedButton(
              onPressed: null,
             ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width:70.0,
                  height:70.0,
                  child: RaisedButton(
                    onPressed: null,
                  ),
                ),
                Container(
                  width:70.0,
                  height:70.0,
                  child: RaisedButton(
                    onPressed: null,
                  ),
                ),
                Container(
                  width:70.0,
                  height:70.0,
                  child: RaisedButton(
                    onPressed: null,
                  ),
                ),
              ]
            ),
            Container(
              width:double.infinity,
              height:70.0,
              margin: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
              child: RaisedButton(
                onPressed: null,
              ),
            ),
            Container(
              width:double.infinity,
              height:70.0,
              margin: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
              child: RaisedButton(
                onPressed: null,
              ),
            ),
              Container(
              width:double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:[
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width:70.0,
                        height:70.0,
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                        child: RaisedButton(
                          onPressed: null,
                        ),
                      ),
                      Container(
                        width:70.0,
                        height:70.0,
                        margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                        child: RaisedButton(
                          onPressed: null,
                        ),
                      ),
                    ]
                  ),
                  Container(
                    width:180.0,
                    height:180.0,
                    child: RaisedButton(
                      onPressed: null,
                    ),
                  ),
                ]
              )
            )
          ],
        )
    );
  }
}
