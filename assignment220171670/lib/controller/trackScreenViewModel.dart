import 'package:flutter/foundation.dart';

import './../services/serviceLocator.dart';
import './../services/track/trackService.dart';

class TrackScreenViewModel extends ChangeNotifier {
  final TrackService _trackService = serviceLocator<TrackService>();

  List<int> _completedAssignments = [];

  double _sumOfScores = 0.0;

  double get score => _sumOfScores;

  List<int> get completedAssignments => _completedAssignments;

  void addScore(double newScore) {
    _sumOfScores = _trackService.addScore(_sumOfScores, newScore);
    notifyListeners();
  }

  void addAssignment(int newAssignement) {
    _completedAssignments =
        _trackService.addAssignment(_completedAssignments, newAssignement);
    notifyListeners();
  }

  void clearState() {
    _completedAssignments = [];
    _sumOfScores = 0.0;
  }
}
