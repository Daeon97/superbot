// ignore_for_file: public_member_api_docs, avoid_setters_without_getters

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:superbot/resources/strings/characters.dart';
import 'package:superbot/resources/strings/networking.dart';
import 'package:superbot/services/clipboard_service.dart';
import 'package:superbot/services/link_generator_service.dart';

abstract interface class LinkOpsRepository {
  Future<String> buildLink(
    String uid,
  );

  Future<void> copyLinkToClipboard(
    String text,
  );

  Future<bool> verifyLink(
    String link,
  );

  String getUidFromLink(
    String link,
  );
}

final class LinkOpsRepositoryImplementation implements LinkOpsRepository {
  const LinkOpsRepositoryImplementation({
    required LinkGeneratorService linkGeneratorService,
    required ClipboardService clipboardService,
    required FirebaseFirestore firebaseFirestore,
  })  : _linkGeneratorService = linkGeneratorService,
        _clipboardService = clipboardService,
        _database = firebaseFirestore;

  final LinkGeneratorService _linkGeneratorService;
  final ClipboardService _clipboardService;
  final FirebaseFirestore _database;

  @override
  Future<String> buildLink(
    String uid,
  ) =>
      _linkGeneratorService.buildLink(
        uid,
      );

  @override
  Future<void> copyLinkToClipboard(
    String text,
  ) =>
      _clipboardService.setData(
        text,
      );

  @override
  Future<bool> verifyLink(
    String link,
  ) async {
    final uid = getUidFromLink(
      link,
    );

    final documentReference = _database
        .collection(
          usersCollection,
        )
        .doc(
          uid,
        );
    final documentSnapshot = await documentReference.get();
    return documentSnapshot.exists &&
        documentSnapshot.data()![inviteLinkField] as String == link;
  }

  @override
  String getUidFromLink(
    String link,
  ) =>
      link
          .split(
            forwardSlash,
          )
          .last;
}
