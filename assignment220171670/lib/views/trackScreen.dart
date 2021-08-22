import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './components/textboxWithLabel.dart';
import './components/dropdownWithLabel.dart';
import './components/button.dart';
import './../controller/trackScreenViewModel.dart';

class TrackScreen extends StatefulWidget {
  TrackScreen({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  _TrackScreenState createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /* 
    ID Number of [Member] attempting the LOG IN
  */
  String score = "nill";
  /*
    Password of [Member] attempting the LOG IN
  */
  int assignmentNumber = 1;

  @override
  Widget build(BuildContext context) {
    double scoreThreshold = 10.0;
    return Form(
      key: _formKey,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.84,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  FormField<int>(
                    builder: (FormFieldState<int> state) => DropdownWithLabel(
                      label: "Assignment Number",
                      dropdownValue: assignmentNumber,
                      onChanged: (currentValue) {
                        setState(() {
                          assignmentNumber = currentValue!;
                        });
                      },
                      choices: [1, 2, 3, 4, 5, 6],
                    ),
                    validator: (int? value) {
                      if (Provider.of<TrackScreenViewModel>(context,
                              listen: false)
                          .completedAssignments
                          .containsKey(assignmentNumber)) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Score for this assignment already added')));
                        return 'Score for this assignment already added';
                      }
                      ;
                    },
                  ),
                  FormField<String>(
                    builder: (FormFieldState<String> state) => TextboxWithLabel(
                      label: "Score",
                      errorText: state.errorText,
                      onTextChanged: (currentValue) {
                        setState(() {
                          score = currentValue;
                        });
                      },
                    ),
                    validator: (String? value) {
                      if (score.isEmpty || score == 'nill') {
                        return 'Please enter a score';
                      }
                      if (score.contains(RegExp(r'[A-Za-z]'))) {
                        return 'Please enter valid score';
                      }
                      if (double.parse(score) > scoreThreshold) {
                        return 'Each assignment is out of 10 marks';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 80.0, bottom: 15.0),
                    child: Button(
                      buttonText: "SUBMIT",
                      isCompressed: true,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final stateSetter = Provider.of<TrackScreenViewModel>(
                              context,
                              listen: false);
                          stateSetter.addAssignment(widget.uid,
                              assignmentNumber, double.parse(score));
                          stateSetter.addScore(widget.uid, double.parse(score));
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
