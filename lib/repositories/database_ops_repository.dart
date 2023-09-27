// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class DatabaseOpsRepository {}

final class DatabaseOpsRepositoryImplementation
    implements DatabaseOpsRepository {
  const DatabaseOpsRepositoryImplementation(
    FirebaseFirestore firebaseFirestore,
  ) : _database = firebaseFirestore;

  final FirebaseFirestore _database;


}
