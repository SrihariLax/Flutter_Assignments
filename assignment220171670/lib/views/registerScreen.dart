import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import './homeScreen.dart';
import './settingsScreen.dart';
import './components/myScaffold.dart';
import './components/textboxWithLabel.dart';
import './components/dropdownWithLabel.dart';
import './components/button.dart';
import './../model/member.dart';
import './../model/googleUser.dart';
import './../services/storage/storageService.dart';
import './../services/serviceLocator.dart';
import './../services/database/databaseService.dart';
import './../services/authentication/authService.dart';

const hintTextList = [
  "Please enter your BITS ID Number",
  "Please enter your password",
  "Please enter your name",
  //"Please enter your gmail id"
];

enum ExcitedChoice { Yes, No }

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /* 
    ID Number of [Member] registering
  */
  String _idNumber = 'IDNumber';
  /*
    Password of [Member] registering
  */
  String _password = 'password';
  /*
    Batch of [Member] registering selected from dropdown
  */
  int _batch = 2017;
  /*
    Name of the [Member]
  */
  String _name = "Name";
  /*
    Stores boolean whether registering [Member] wants regular updates
  */
  bool _regularUpdates = false;
  /*
    Stores boolean whether registering [Member] is excited
  */
  ExcitedChoice? _excited = ExcitedChoice.Yes;

  bool isUsernameTaken = false;

  StorageService _storageService = serviceLocator<StorageService>();
  DatabaseService _databaseService = serviceLocator<DatabaseService>();
  AuthService _authService = serviceLocator<AuthService>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Form(
          key: _formKey,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.84,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  showBody(context),
                  showQuestion(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String encryptPassword(String password) {
    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    return encrypter.encrypt(password, iv: iv).base64;
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
            if (_idNumber.isEmpty || _idNumber == 'IDNumber') {
              return 'Please enter some text';
            }
            String pattern =
                r'^(2016|2017|2018|2019|2020|2021)....[0-9]{4}(P|G|H|D)';
            RegExp regex = new RegExp(pattern);
            if (!regex.hasMatch(_idNumber)) {
              return 'Enter Valid ID Number';
            }
            _checkUsername(_idNumber);
            if (isUsernameTaken) {
              return 'User already exists!';
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
            if (_password.isEmpty || _password == 'password') {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        FormField<String>(
          builder: (FormFieldState<String> state) => TextboxWithLabel(
            label: "Name",
            hintText: hintTextList[2],
            onTextChanged: (currentValue) {
              setState(() {
                _name = currentValue;
              });
            },
          ),
        ),
        /*FormField<String>(
          builder: (FormFieldState<String> state) => TextboxWithLabel(
            label: "Gmail ID",
            hintText: hintTextList[3],
            errorText: state.errorText,
            onTextChanged: (currentValue) {
              setState(() {
                _gmail = currentValue;
              });
            },
          ),
          validator: (String? value) {
            if (_gmail.isEmpty || _gmail == 'gmail') {
              return 'Please enter some text';
            }
            String pattern = r'^[a-z0-9](\.?[a-z0-9]){5,}@.+\..+$';
            RegExp regex = new RegExp(pattern);
            if (!regex.hasMatch(_gmail)) {
              return 'Enter Valid Gmail ID';
            }
            return null;
          },
        ),*/
        FormField<String>(
          builder: (FormFieldState<String> state) => DropdownWithLabel(
            label: "Batch",
            dropdownValue: _batch,
            onChanged: (currentValue) {
              setState(() {
                _batch = currentValue!;
              });
            },
            choices: [2016, 2017, 2018, 2019, 2020, 2021],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Receive Regular Updates",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Switch(
                value: _regularUpdates,
                onChanged: (value) {
                  setState(() {
                    _regularUpdates = value;
                  });
                },
                activeTrackColor: Colors.grey,
                activeColor: Color(0xff2FC4B2),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(5.0, 5.0, 70.0, 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Are you excited for this !!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Radio<ExcitedChoice>(
                        value: ExcitedChoice.Yes,
                        groupValue: _excited,
                        onChanged: (ExcitedChoice? value) {
                          setState(() {
                            _excited = value;
                          });
                        },
                      ),
                      Text(
                        'Yes',
                        style: new TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<ExcitedChoice>(
                        value: ExcitedChoice.No,
                        groupValue: _excited,
                        onChanged: (ExcitedChoice? value) {
                          setState(() {
                            _excited = value;
                          });
                        },
                      ),
                      Text(
                        'No',
                        style: new TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Button(
            buttonText: "REGISTER",
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                GoogleUser? user = await _authService.googleSignIn();
                if (user != null) {
                  Member newMember = Member(
                      idNumber: _idNumber,
                      password: encryptPassword(_password),
                      name: _name,
                      gmail: user.gmail,
                      batch: _batch,
                      regularUpdates: _regularUpdates,
                      excited: (_excited == ExcitedChoice.No ? false : true));

                  await _databaseService.updateData(
                      user.uid, newMember, Map<String, String>(), 0);

                  _storageService.saveName(_name);
                  _storageService.saveIdNumber(_idNumber);
                  _storageService.saveLoginData(true);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyScaffold(
                        bottomBar: true,
                        child: HomeScreen(
                          isPreviousPageRegister: false,
                          uid: user.uid,
                          homeBio: "homeBio",
                        ),
                        settingsChild: SettingsScreen(),
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Unable to complete registration : Invalid google account')));
                }
              }
            },
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
          "Already have an account ? ",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        InkWell(
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xff2FC4B2),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  _checkUsername(String username) {
    setState(() {
      isUsernameTaken = false;
    });
    if (!username.isEmpty) {
      _databaseService.isIdNumberRegistered(_idNumber).then(
            (value) => setState(
              () {
                isUsernameTaken = value != null;
              },
            ),
          );
    }
  }
}
