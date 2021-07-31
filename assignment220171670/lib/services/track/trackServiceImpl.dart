import './trackService.dart';

class TrackServiceImpl extends TrackService {
  @override
  int getProgress() {
    return 1;
  }

  @override
  double addScore(double currentSum, double newScore) {
    return currentSum + newScore;
  }

  @override
  int getPercentage(int completedAssignments) {
    return (completedAssignments * 100 / 6).round();
  }

  @override
  List<int> addAssignment(List<int> completedAssignments, int newAssignment) {
    completedAssignments.add(newAssignment);
    return completedAssignments;
  }
}
