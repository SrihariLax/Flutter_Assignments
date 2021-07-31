import 'package:flutter/foundation.dart';

import './../services/serviceLocator.dart';
import './../services/storage/storageService.dart';

enum HomeBio { Name, IdNumber }

class SettingsScreenViewModel extends ChangeNotifier {
  final StorageService _storageService = serviceLocator<StorageService>();

  HomeBio _homeBio = HomeBio.IdNumber;

  getHomeBio() async {
    String homeBioString = "homeBio";
    if (_homeBio == HomeBio.Name) {
      homeBioString = await _storageService.getName();
    } else {
      homeBioString = await _storageService.getName();
    }
    notifyListeners();
    return homeBioString;
  }
}
