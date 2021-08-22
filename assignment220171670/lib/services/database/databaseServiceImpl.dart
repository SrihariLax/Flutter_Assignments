import 'package:assignment220171670/model/member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './databaseService.dart';
import '/model/member.dart';

class DatabaseServiceImpl extends DatabaseService {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection("members");

  @override
  Future updateData(String uid, Member member,
      Map<String, String> completedAssignments, double score) async {
    return await collection.doc(uid).set(
      {
        'idNumber': member.idNumber,
        'name': member.name,
        'gmail': member.gmail,
        'password': member.password,
        'batch': member.batch,
        'regularUpdates': member.regularUpdates,
        'excited': member.excited,
        'completedAssignments': completedAssignments,
        'score': score,
      },
      SetOptions(merge: true),
    ).whenComplete(
      () => print('Done adding data to DB'),
    );
  }

  @override
  Future updateTrackData(String uid, Map<String, String> completedAssignments,
      double score) async {
    return await collection.doc(uid).update(
      {
        'completedAssignments': completedAssignments,
        'score': score,
      },
    ).whenComplete(
      () => print('Done updating data to DB'),
    );
  }

  @override
  Future doesUserExist(String username, String password) async {
    List<DocumentSnapshot> documents = await collection
        .where('idNumber', isEqualTo: username)
        .where('password', isEqualTo: password)
        .get()
        .then((docCollection) => docCollection.docs);

    if (documents.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future getNameWithIdNumber(String idNumber) async {
    List<DocumentSnapshot> documents = await collection
        .where('idNumber', isEqualTo: idNumber)
        .get()
        .then((docCollection) => docCollection.docs);

    if (documents.isEmpty) {
      return 'invalid';
    } else {
      return (documents[0].data() as Map)['name'];
    }
  }

  Future getName(String uid) async {
    DocumentSnapshot snapshot = await collection.doc(uid).get();
    if (snapshot.exists) {
      return (snapshot.data() as Map)['name'];
    }
  }

  Future getIdNumber(String uid) async {
    DocumentSnapshot snapshot = await collection.doc(uid).get();
    if (snapshot.exists) {
      return (snapshot.data() as Map)['idNumber'];
    }
  }

  Future isEmailRegistered(String gmail) async {
    List<DocumentSnapshot> documents = await collection
        .where('gmail', isEqualTo: gmail)
        .get()
        .then((docCollection) => docCollection.docs);

    if (documents.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future isIdNumberRegistered(String idNumber) async {
    List<DocumentSnapshot> documents = await collection
        .where('idNumber', isEqualTo: idNumber)
        .get()
        .then((docCollection) => docCollection.docs);

    if (documents.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future getUIDfromIdNumber(String idNumber) async {
    List<DocumentSnapshot> documents = await collection
        .where('idNumber', isEqualTo: idNumber)
        .get()
        .then((docCollection) => docCollection.docs);

    if (documents.isEmpty) {
      return 'invalid';
    } else {
      return documents[0].id.toString();
    }
  }

  @override
  Future getTrackDataScore(String uid) async {
    DocumentSnapshot snapshot = await collection.doc(uid).get();
    if (snapshot.exists) {
      return (snapshot.data() as Map)['score'];
    }
  }

  @override
  Future getTrackDataAssignments(String uid) async {
    DocumentSnapshot snapshot = await collection.doc(uid).get();
    if (snapshot.exists) {
      return (snapshot.data() as Map)['completedAssignments'];
    }
  }
}
