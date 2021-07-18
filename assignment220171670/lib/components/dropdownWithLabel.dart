import 'package:flutter/material.dart';

/*
  Groups together a DropDown and its Label on top.
*/
class DropdownWithLabel extends StatelessWidget {
  DropdownWithLabel(
      {Key? key,
      required this.label,
      required this.choices,
      required this.onChanged,
      required this.dropdownValue})
      : super(key: key);

  /*
    label displayed on top of the [TextField]
  */
  final String label;
  /*
    Value chosen in the dropdown
  */
  final int dropdownValue;
  /*
    List of available choices for the dropdown
  */
  final List<int> choices;
  /*
    onChanged for the DropDown
  */
  final Function(int?)? onChanged;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            decoration: BoxDecoration(
              color: Color(0xffeeeeee),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: dropdownValue,
                itemHeight: 50.0,
                style: TextStyle(fontSize: 15.0, color: Colors.black),
                items: choices.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
