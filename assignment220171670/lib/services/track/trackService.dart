abstract class TrackService {
  double addScore(double currentSum, double newScore);

  int getPercentage(int completedAssignemnts);

  List<int> addAssignment(List<int> completedAssignments, int newAssignment);
}
