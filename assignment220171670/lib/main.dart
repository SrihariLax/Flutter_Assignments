import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './views/loginScreen.dart';
import './views/components/myScaffold.dart';
import './services/serviceLocator.dart';
import './controller/trackScreenViewModel.dart';
import './controller/settingsScreenViewModel.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServiceLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TrackScreenViewModel()),
        ChangeNotifierProvider(create: (context) => SettingsScreenViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyScaffold(
        child: LoginScreen(),
      ),
    );
  }
}
