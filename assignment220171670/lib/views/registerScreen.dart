import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import './homeScreen.dart';
import './settingsScreen.dart';
import './components/myScaffold.dart';
import './components/textboxWithLabel.dart';
import './components/dropdownWithLabel.dart';
import './components/button.dart';
import './../model/member.dart';
import './../model/resource/resource.dart';
import './../services/storage/storageService.dart';
import './../services/serviceLocator.dart';

const hintTextList = [
  "Please enter your BITS ID Number",
  "Please enter your password",
  "Please enter your name",
];

enum ExcitedChoice { Yes, No }

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key, required this.DTOresource}) : super(key: key);
  final Resource DTOresource;
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
  /* 
    Transmission resource passed along to next navigated pages and received back from next pages on pop.
    Acts like a travelling database.
  */
  Resource DTOresource = Resource();

  StorageService _storageService = serviceLocator<StorageService>();
  @override
  Widget build(BuildContext context) {
    DTOresource = widget.DTOresource;
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
            for (Member member in DTOresource.membersList ?? []) {
              if (member.idNumber == _idNumber) {
                return 'User already exists!';
              }
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
                Member newMember = Member(
                    idNumber: _idNumber,
                    password: encryptPassword(_password),
                    name: _name,
                    batch: _batch,
                    regularUpdates: _regularUpdates,
                    excited: (_excited == ExcitedChoice.No ? false : true));
                DTOresource.membersList?.add(newMember);
                _storageService.saveName(_name);
                _storageService.saveIdNumber(_idNumber);
                _storageService.saveLoginData(true);
                DTOresource = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyScaffold(
                      bottomBar: true,
                      child: HomeScreen(
                        isPreviousPageRegister: false,
                        homeBio: "homeBio",
                      ),
                      settingsChild: SettingsScreen(),
                      DTOresource: DTOresource,
                    ),
                  ),
                );
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
            Navigator.pop(context, DTOresource);
          },
        ),
      ],
    );
  }
}
