// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:superbot/injection_container.dart';
import 'package:superbot/resources/strings/networking.dart';
import 'package:superbot/resources/strings/ui.dart';
import 'package:superbot/utils/enums.dart' as enums;

extension UserType on User {
  Future<enums.Type> get type async {
    final documentSnapshot = await sl<FirebaseFirestore>()
        .collection(
          usersCollection,
        )
        .doc(
          uid,
        )
        .get();

    return switch (documentSnapshot.data()?[typeField]) {
      supervisorValue => enums.Type.supervisor,
      studentValue => enums.Type.student,
      _ => throw Exception(
          couldNotResolveUserType,
        ),
    };
  }
}
