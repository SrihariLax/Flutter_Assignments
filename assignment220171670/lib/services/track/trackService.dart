abstract class TrackService {
  double addScore(double currentSum, double newScore);

  int getPercentage(int completedAssignments);

  Map<int, double> addAssignment(
      Map<int, double> completedAssignments, int newAssignment, double score);
}
