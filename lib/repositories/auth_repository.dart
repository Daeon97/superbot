// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:superbot/models/failure.dart';
import 'package:superbot/repositories/link_ops_repository.dart';
import 'package:superbot/resources/strings/networking.dart';
import 'package:superbot/resources/strings/ui.dart';
import 'package:superbot/services/link_generator_service.dart';
import 'package:superbot/utils/enums.dart' as enums;
import 'package:superbot/utils/extensions.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, enums.Type>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, enums.Type>> signUpStudent({
    required String name,
    required String email,
    required String degreeType,
    required String courseOfStudy,
    required String regNo,
    required String supervisorUid,
    required String password,
  });

  Future<Either<Failure, enums.Type>> signUpSupervisor({
    required String name,
    required String email,
    required String status,
    required String password,
  });

  User? get user;

  Future<void> signOut();
}

final class AuthRepositoryImplementation implements AuthRepository {
  const AuthRepositoryImplementation({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
    required LinkGeneratorService linkGeneratorService,
  })  : _auth = firebaseAuth,
        _database = firebaseFirestore,
        _linkGeneratorService = linkGeneratorService;

  final FirebaseAuth _auth;
  final FirebaseFirestore _database;
  final LinkGeneratorService _linkGeneratorService;

  @override
  Future<Either<Failure, enums.Type>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userType = await userCredential.user!.type;
      return Right(
        userType,
      );
    } catch (e) {
      if (user != null) {
        await signOut();
      }

      return Left(
        Failure(
          switch (e) {
            FirebaseAuthException() => e.message ?? anErrorOccurred,
            _ => anErrorOccurred,
          },
        ),
      );
    }
  }

  @override
  Future<Either<Failure, enums.Type>> signUpStudent({
    required String name,
    required String email,
    required String degreeType,
    required String courseOfStudy,
    required String regNo,
    required String supervisorUid,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final studentData = {
        nameField: name,
        degreeTypeField: degreeType,
        courseOfStudyField: courseOfStudy,
        regNoField: regNo,
        typeField: studentValue,
        createdAtField: FieldValue.serverTimestamp(),
      };
      final usersCollectionReference = _database.collection(
        usersCollection,
      );

      final studentDocumentReference = usersCollectionReference.doc(
        userCredential.user!.uid,
      );
      await studentDocumentReference.set(
        studentData,
      );

      final supervisorUpdateData = {
        connectedAtField: FieldValue.serverTimestamp(),
      };
      await usersCollectionReference
          .doc(
            supervisorUid,
          )
          .collection(
            studentsCollection,
          )
          .doc(
            userCredential.user!.uid,
          )
          .set(
            supervisorUpdateData,
          );

      final studentUpdateData = {
        supervisorIdField: supervisorUid,
      };

      await studentDocumentReference.update(
        studentUpdateData,
      );

      return const Right(
        enums.Type.student,
      );
    } catch (e) {
      if (user != null) {
        final usersCollectionReference = _database.collection(
          usersCollection,
        );

        final studentDocumentReference = usersCollectionReference.doc(
          user!.uid,
        );
        final studentDocumentSnapshot = await studentDocumentReference.get();

        if (studentDocumentSnapshot.exists) {
          await studentDocumentReference.delete();
        }

        final thisStudentsDocumentInSupervisorDocumentReference =
            usersCollectionReference
                .doc(
                  supervisorUid,
                )
                .collection(
                  studentsCollection,
                )
                .doc(
                  user!.uid,
                );

        final thisStudentsDocumentInSupervisorDocumentSnapshot =
            await thisStudentsDocumentInSupervisorDocumentReference.get();

        if (thisStudentsDocumentInSupervisorDocumentSnapshot.exists) {
          await thisStudentsDocumentInSupervisorDocumentReference.delete();
        }

        await user!.delete();
      }

      return Left(
        Failure(
          switch (e) {
            FirebaseAuthException() => e.message ?? anErrorOccurred,
            _ => anErrorOccurred,
          },
        ),
      );
    }
  }

  @override
  Future<Either<Failure, enums.Type>> signUpSupervisor({
    required String name,
    required String email,
    required String status,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final inviteLink = await _linkGeneratorService.buildLink(
        userCredential.user!.uid,
      );

      final data = {
        nameField: name,
        statusField: status,
        inviteLinkField: inviteLink,
        typeField: supervisorValue,
        createdAtField: FieldValue.serverTimestamp(),
      };

      await _database
          .collection(
            usersCollection,
          )
          .doc(
            userCredential.user!.uid,
          )
          .set(
            data,
          );

      return const Right(
        enums.Type.supervisor,
      );
    } catch (e) {
      if (user != null) {
        final userDocumentReference = _database
            .collection(
              usersCollection,
            )
            .doc(
              user!.uid,
            );
        final userDocumentSnapshot = await userDocumentReference.get();

        if (userDocumentSnapshot.exists) {
          await userDocumentReference.delete();
        }

        await user!.delete();
      }

      return Left(
        Failure(
          switch (e) {
            FirebaseAuthException() => e.message ?? anErrorOccurred,
            _ => anErrorOccurred,
          },
        ),
      );
    }
  }

  @override
  User? get user => _auth.currentUser;

  @override
  Future<void> signOut() => _auth.signOut();
}
