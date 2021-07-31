import 'package:flutter/material.dart';

import './../model/resource/resource.dart';

enum HomeBio { Name, Id }

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key, this.DTOresource}) : super(key: key);

  final Resource? DTOresource;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  HomeBio? _homeBio = HomeBio.Name;

  Widget build(BuildContext) {
    return Container(
      padding: EdgeInsets.fromLTRB(30.0, 50.0, 80.0, 100.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Home Bio",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Radio<HomeBio>(
                    value: HomeBio.Name,
                    groupValue: _homeBio,
                    onChanged: (HomeBio? value) {
                      setState(() {
                        _homeBio = value;
                      });
                    },
                  ),
                  Text(
                    'Name',
                    style: new TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio<HomeBio>(
                    value: HomeBio.Id,
                    groupValue: _homeBio,
                    onChanged: (HomeBio? value) {
                      setState(() {
                        _homeBio = value;
                      });
                    },
                  ),
                  Text(
                    'Id',
                    style: new TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
