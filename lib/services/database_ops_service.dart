// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:superbot/resources/strings/networking.dart';

abstract interface class DatabaseOpsService {
  Stream<QuerySnapshot<Map<String, dynamic>>> getStudents(
    String uid,
  );
}

final class DatabaseOpsServiceImplementation implements DatabaseOpsService {
  const DatabaseOpsServiceImplementation(
    FirebaseFirestore firebaseFirestore,
  ) : _database = firebaseFirestore;

  final FirebaseFirestore _database;

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getStudents(
    String uid,
  ) =>
      _database
          .collection(
            usersCollection,
          )
          .doc(uid)
          .collection(
            studentsCollection,
          )
          .snapshots();
}
