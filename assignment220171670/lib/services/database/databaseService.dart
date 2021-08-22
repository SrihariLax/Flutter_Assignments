import 'package:assignment220171670/model/member.dart';

abstract class DatabaseService {
  Future updateData(String uid, Member member,
      Map<String, String> completedAssignments, double score);

  Future updateTrackData(
      String uid, Map<String, String> completedAssignments, double score);

  Future doesUserExist(String idNumber, String password);

  Future getNameWithIdNumber(String idNumber);

  Future getName(String uid);

  Future getIdNumber(String uid);

  Future isEmailRegistered(String gmail);

  Future isIdNumberRegistered(String idNumber);

  Future getUIDfromIdNumber(String idNumber);

  Future getTrackDataScore(String uid);

  Future getTrackDataAssignments(String uid);
}
