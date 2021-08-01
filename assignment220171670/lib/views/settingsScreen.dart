import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../model/resource/resource.dart';
import './../controller/settingsScreenViewModel.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key, this.DTOresource}) : super(key: key);

  final Resource? DTOresource;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  HomeBio? _homeBio = HomeBio.Name;

  Widget build(BuildContext) {
    final stateGetter =
        Provider.of<SettingsScreenViewModel>(context, listen: false);
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
                    groupValue: stateGetter.homeBio,
                    onChanged: (HomeBio? value) {
                      setState(() {
                        _homeBio = value;
                      });
                      final stateSetter = Provider.of<SettingsScreenViewModel>(
                          context,
                          listen: false);
                      stateSetter.setHomeBio(_homeBio ?? HomeBio.IdNumber);
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
                    value: HomeBio.IdNumber,
                    groupValue: stateGetter.homeBio,
                    onChanged: (HomeBio? value) {
                      setState(() {
                        _homeBio = value;
                      });
                      final stateSetter = Provider.of<SettingsScreenViewModel>(
                          context,
                          listen: false);
                      stateSetter.setHomeBio(_homeBio ?? HomeBio.Name);
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
