import 'package:flutter/foundation.dart';

import './../services/serviceLocator.dart';
import './../services/track/trackService.dart';
import './../services/database/databaseService.dart';

class TrackScreenViewModel extends ChangeNotifier {
  final TrackService _trackService = serviceLocator<TrackService>();
  final DatabaseService _databaseService = serviceLocator<DatabaseService>();

  Map<int, double> _completedAssignments = Map();

  double _sumOfScores = 0.0;

  double get score => _sumOfScores;

  Map<int, double> get completedAssignments => _completedAssignments;

  void addScore(String uid, double newScore) async {
    _sumOfScores = _trackService.addScore(_sumOfScores, newScore);
    Map<String, String> temp = new Map();
    completedAssignments.forEach((key, value) {
      temp[key.toString()] = value.toString();
    });
    await _databaseService.updateTrackData(uid, temp, score);
    notifyListeners();
  }

  void addAssignment(
      String uid, int newAssignement, double assignmentScore) async {
    _completedAssignments = _trackService.addAssignment(
        _completedAssignments, newAssignement, assignmentScore);
    Map<String, String> temp = new Map();
    completedAssignments.forEach((key, value) {
      temp[key.toString()] = value.toString();
    });
    await _databaseService.updateTrackData(uid, temp, score);
    notifyListeners();
  }

  void initializeState(String uid) async {
    _sumOfScores = await _databaseService.getTrackDataScore(uid);
    Map<String, dynamic> temp =
        await _databaseService.getTrackDataAssignments(uid);
    Map<int, double> mp = Map();
    temp.forEach((key, value) {
      mp[int.parse(key)] = double.parse(value);
    });
    _completedAssignments = mp;
    ;
    notifyListeners();
  }

  void clearState() {
    _completedAssignments = Map();
    _sumOfScores = 0.0;
  }
}
