// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:superbot/models/student.dart';
import 'package:superbot/models/supervisor.dart';
import 'package:superbot/resources/strings/networking.dart';
import 'package:superbot/services/database_ops_service.dart';

abstract interface class DatabaseOpsRepository {
  Stream<List<(Student, String)>> getStudents(
    String uid,
  );

  Future<Supervisor> getSupervisor(
    String uid,
  );
}

final class DatabaseOpsRepositoryImplementation
    implements DatabaseOpsRepository {
  const DatabaseOpsRepositoryImplementation({
    required DatabaseOpsService databaseOpsService,
    required FirebaseFirestore firebaseFirestore,
  })  : _databaseOpsService = databaseOpsService,
        _database = firebaseFirestore;

  final DatabaseOpsService _databaseOpsService;
  final FirebaseFirestore _database;

  @override
  Stream<List<(Student, String)>> getStudents(
    String uid,
  ) {
    late StreamController<List<(Student, String)>> streamController;
    late StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
        streamSubscription;

    streamController = StreamController<List<(Student, String)>>(
      onListen: () {
        streamSubscription = _databaseOpsService
            .getStudents(
          uid,
        )
            .listen(
          (querySnapshot) async {
            final studentUids = querySnapshot.docs
                .map(
                  (
                    queryDocumentSnapshot,
                  ) =>
                      queryDocumentSnapshot.reference.id,
                )
                .toList();

            final students = <(Student, String)>[];

            for (final studentUid in studentUids) {
              final studentDocumentSnapshot = await _database
                  .collection(
                    usersCollection,
                  )
                  .doc(
                    studentUid,
                  )
                  .get();

              students.add(
                (
                  Student.fromJson(
                    studentDocumentSnapshot.data()!,
                  ),
                  studentUid,
                ),
              );
            }

            streamController.sink.add(
              students,
            );
          },
        );
      },
      onCancel: () async {
        await streamSubscription.cancel();
        await streamController.sink.close();
        await streamController.close();
      },
    );
    return streamController.stream;
  }

  @override
  Future<Supervisor> getSupervisor(
    String uid,
  ) async {
    final usersCollectionReference = _database.collection(
      usersCollection,
    );
    final supervisorUid = (await usersCollectionReference
            .doc(
              uid,
            )
            .get())
        .data()![supervisorIdField] as String;

    final supervisorDocumentSnapshot = await usersCollectionReference
        .doc(
          supervisorUid,
        )
        .get();

    return Supervisor.fromJson(
      supervisorDocumentSnapshot.data()!,
    );
  }
}
