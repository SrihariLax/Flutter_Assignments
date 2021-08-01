import 'package:flutter/foundation.dart';

import './../services/serviceLocator.dart';
import './../services/storage/storageService.dart';

enum HomeBio { Name, IdNumber }

class SettingsScreenViewModel extends ChangeNotifier {
  final StorageService _storageService = serviceLocator<StorageService>();

  HomeBio _homeBio = HomeBio.Name;

  String _homeBioString = 'loading';

  HomeBio get homeBio => _homeBio;

  String get homeBioString => _homeBioString;

  setHomeBio(HomeBio setting) {
    this._homeBio = setting;
    notifyListeners();
  }

  String getHomeBio() {
    if (_homeBio == HomeBio.Name) {
      _storageService.getName().then((value) => this._homeBioString = value);
    } else {
      _storageService
          .getIdNumber()
          .then((value) => this._homeBioString = value);
    }
    return homeBioString;
  }
}
