// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:superbot/models/failure.dart';
import 'package:superbot/utils/extensions.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> signUpSupervisor({
    required String name,
    required String email,
    required String status,
    required String password,
  });

  Future<Either<Failure, User>> signUpStudent({
    required String name,
    required String email,
    required String status,
    required String degree,
    required String courseOfStudy,
    required String regNo,
    required String password,
  });
}

final class AuthRepositoryImplementation implements AuthRepository {
  const AuthRepositoryImplementation({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  })  : _auth = firebaseAuth,
        _database = firebaseFirestore;

  final FirebaseAuth _auth;
  final FirebaseFirestore _database;

  @override
  Future<Either<Failure, User>> signIn({
    required String email,
    required String password,
  }) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // userCredential.user?.uid
    userCredential.user?.type;
    return Left(Failure(''));
  }

  @override
  Future<Either<Failure, User>> signUpSupervisor({
    required String name,
    required String email,
    required String status,
    required String password,
  }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return Left(Failure(''));
  }

  @override
  Future<Either<Failure, User>> signUpStudent({
    required String name,
    required String email,
    required String status,
    required String degree,
    required String courseOfStudy,
    required String regNo,
    required String password,
  }) async {
    return Left(Failure(''));
  }
}
