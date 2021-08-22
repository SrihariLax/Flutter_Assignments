import './trackService.dart';

class TrackServiceImpl extends TrackService {
  @override
  double addScore(double currentSum, double newScore) {
    return currentSum + newScore;
  }

  @override
  int getPercentage(int completedAssignments) {
    return (completedAssignments * 100 / 6).round();
  }

  @override
  Map<int, double> addAssignment(
      Map<int, double> completedAssignments, int newAssignment, double score) {
    completedAssignments[newAssignment] = score;
    return completedAssignments;
  }
}
