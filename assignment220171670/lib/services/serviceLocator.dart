import 'package:get_it/get_it.dart';

import './storage/storageService.dart';
import './storage/storageServiceImpl.dart';
import './track/trackService.dart';
import './track/trackServiceImpl.dart';
import './../controller/trackScreenViewModel.dart';
import './../controller/settingsScreenViewModel.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator
      .registerLazySingleton<StorageService>(() => StorageServiceImpl());

  serviceLocator.registerLazySingleton<TrackService>(() => TrackServiceImpl());

  serviceLocator
      .registerFactory<TrackScreenViewModel>(() => TrackScreenViewModel());

  serviceLocator.registerFactory<SettingsScreenViewModel>(
      () => SettingsScreenViewModel());
}
