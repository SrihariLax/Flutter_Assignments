import 'package:assignment220171670/services/authentication/authService.dart';
import 'package:assignment220171670/views/settingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import './homeScreen.dart';
import './registerScreen.dart';
import './components/myScaffold.dart';
import './components/textboxWithLabel.dart';
import './components/button.dart';
import './../model/googleUser.dart';
import './../services/storage/storageService.dart';
import './../services/database/databaseService.dart';
import './../services/serviceLocator.dart';
import './../services/authentication/authService.dart';

/*
  Used as placeholder for ID Number and Password textboxes
*/
const hintTextList = [
  "Please enter your BITS ID Number",
  "Please enter your password"
];

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthService _authService = serviceLocator<AuthService>();

  /* 
    ID Number of [Member] attempting the LOG IN
  */
  String _idNumber = 'IDNumber';
  /*
    Password of [Member] attempting the LOG IN
  */
  String _password = '';
  /*
    stores boolean whether [Member] is already logged in as per shared preferences
  */
  bool isLoggedIn = false;
  /*
    Stores the current [Member]'s UID
  */
  String uid = 'unknown';

  StorageService _storageService = serviceLocator<StorageService>();
  DatabaseService _databaseService = serviceLocator<DatabaseService>();

  @override
  void initState() {
    super.initState();
    initializeLoggedIn().whenComplete(() {
      setState(() {});
      if (this.isLoggedIn) {
        navigateToHome();
      }
    });
  }

  Future<void> initializeLoggedIn() async {
    this.isLoggedIn = await _storageService.getLoginData();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.84,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              showHeader(context),
              showBody(context),
              showGoogleOption(context),
              showQuestion(context),
            ],
          ),
        ),
      ),
    );
  }

  Future navigateToHome() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyScaffold(
          bottomBar: true,
          child: HomeScreen(
            isPreviousPageRegister: false,
            uid: uid,
            homeBio: "homeBio",
          ),
          settingsChild: SettingsScreen(),
        ),
      ),
    );
  }

  String encryptPassword(String password) {
    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    return encrypter.encrypt(password, iv: iv).base64;
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
    return Column(
      children: [
        FormField<String>(
          builder: (FormFieldState<String> state) => TextboxWithLabel(
            label: "ID Number",
            hintText: hintTextList[0],
            errorText: state.errorText,
            onTextChanged: (currentValue) {
              setState(() {
                _idNumber = currentValue;
              });
            },
          ),
          validator: (String? value) {
            if (_idNumber == 'IDNumber') {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        FormField<String>(
          builder: (FormFieldState<String> state) => TextboxWithLabel(
            label: "Password",
            hintText: hintTextList[1],
            obscureText: true,
            errorText: state.errorText,
            onTextChanged: (currentValue) {
              setState(() {
                _password = currentValue;
              });
            },
          ),
          validator: (String? value) {
            if (_password.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: Button(
              buttonText: "LOG IN",
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  /*dynamic result = await _authService.loginMember(
                      _idNumber, encryptPassword(_password));*/
                  _getUIDfromIdNumber(_idNumber);
                  bool validMember = await _databaseService.doesUserExist(
                      _idNumber, encryptPassword(_password));
                  _storageService.saveName(
                      await _databaseService.getNameWithIdNumber(_idNumber));
                  _storageService.saveIdNumber(_idNumber);
                  if (validMember) {
                    _storageService.saveLoginData(true);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyScaffold(
                          bottomBar: true,
                          child: HomeScreen(
                            isPreviousPageRegister: false,
                            uid: uid,
                            homeBio: "homeBio",
                          ),
                          settingsChild: SettingsScreen(),
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('ID Number or Password is incorrect')));
                  }
                }
              }),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: Text(
            "Forgot Password ?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xff2FC4B2),
            ),
          ),
        ),
      ],
    );
  }

  Widget showGoogleOption(BuildContext context) {
    return InkWell(
      child: Text(
        'Sign In with Google',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xff2FC4B2),
        ),
      ),
      onTap: () async {
        GoogleUser? user = await _authService.googleSignIn();
        bool validMember = false;
        if (user != null &&
            await _databaseService.isEmailRegistered(user.gmail)) {
          validMember = true;
          _storageService.saveName(await _databaseService.getName(user.uid));
          _storageService
              .saveIdNumber(await _databaseService.getIdNumber(user.uid));
        }
        if (validMember) {
          _getUIDfromIdNumber(_idNumber);
          _storageService.saveLoginData(true);
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyScaffold(
                bottomBar: true,
                child: HomeScreen(
                  isPreviousPageRegister: false,
                  uid: user!.uid,
                  homeBio: "homeBio",
                ),
                settingsChild: SettingsScreen(),
              ),
            ),
          );
        } else {
          if (user != null) {
            _authService.signOut();
          }
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'Unable to Sign In with Google : Email not registered')));
        }
      },
    );
  }

  Widget showQuestion(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account ? ",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        InkWell(
          child: Text(
            'Register',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xff2FC4B2),
            ),
          ),
          onTap: () async {
            _authService.signOut();
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyScaffold(
                  setTitle: true,
                  title: "CRUX FLUTTER SUMMER GROUP",
                  backButton: false,
                  child: RegisterScreen(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  _getUIDfromIdNumber(String idNumber) {
    if (!idNumber.isEmpty) {
      _databaseService.getUIDfromIdNumber(_idNumber).then(
            (value) => setState(
              () {
                uid = value;
              },
            ),
          );
    }
  }
}
