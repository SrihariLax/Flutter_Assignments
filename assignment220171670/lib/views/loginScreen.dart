import 'package:assignment220171670/views/settingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:shared_preferences/shared_preferences.dart';

import './homeScreen.dart';
import './registerScreen.dart';
import './components/myScaffold.dart';
import './components/textboxWithLabel.dart';
import './components/button.dart';
import './../model/member.dart';
import './../model/resource/resource.dart';
import './../services/storage/storageService.dart';
import './../services/serviceLocator.dart';

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

  /* 
    ID Number of [Member] attempting the LOG IN
  */
  String _idNumber = 'IDNumber';
  /*
    Password of [Member] attempting the LOG IN
  */
  String _password = '';
  /* 
    Transmission resource passed along to next navigated pages and received back with updates from next pages.
    Acts like a travelling database.

    Currently contains a field which stores a list of registered members (Initialised to empty in the beginning but expandable).
  */
  Resource DTOresource = new Resource(membersList: []);
  /*
    stores boolean whether [Member] is already logged in as per shared preferences
  */
  bool isLoggedIn = false;

  StorageService _storageService = serviceLocator<StorageService>();

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
              showQuestion(context),
            ],
          ),
        ),
      ),
    );
  }

  Future navigateToHome() async {
    DTOresource = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyScaffold(
          bottomBar: true,
          child: HomeScreen(
            isPreviousPageRegister: false,
            homeBio: "homeBio",
            DTOresource: DTOresource,
          ),
          settingsChild: SettingsScreen(
            DTOresource: DTOresource,
          ),
          DTOresource: DTOresource,
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
                  bool validMember = false;
                  for (Member registeredMember
                      in DTOresource.membersList ?? []) {
                    if (registeredMember.idNumber == _idNumber &&
                        registeredMember.password ==
                            encryptPassword(_password)) {
                      validMember = true;
                      _storageService.saveName(registeredMember.name);
                      _storageService.saveIdNumber(registeredMember.idNumber);
                      break;
                    }
                  }
                  if (validMember) {
                    _storageService.saveLoginData(true);
                    DTOresource = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyScaffold(
                          bottomBar: true,
                          child: HomeScreen(
                            isPreviousPageRegister: false,
                            homeBio: "homeBio",
                            DTOresource: DTOresource,
                          ),
                          settingsChild: SettingsScreen(
                            DTOresource: DTOresource,
                          ),
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
            DTOresource = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyScaffold(
                  setTitle: true,
                  title: "CRUX FLUTTER SUMMER GROUP",
                  backButton: false,
                  child: RegisterScreen(
                    DTOresource: DTOresource,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
