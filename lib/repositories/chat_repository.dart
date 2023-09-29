// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:superbot/models/chat.dart';
import 'package:superbot/resources/strings/characters.dart';
import 'package:superbot/resources/strings/local.dart';
import 'package:superbot/resources/strings/networking.dart';
import 'package:superbot/resources/strings/ui.dart';
import 'package:superbot/services/chat_service.dart';
import 'package:superbot/utils/enums.dart' as enums;

abstract interface class ChatRepository {
  Stream<List<Chat>> getChats({
    required String uid,
    required enums.Type userType,
  });

  Future<void> sendMessage({
    required String message,
    required String uid,
  });
}

final class ChatRepositoryImplementation implements ChatRepository {
  const ChatRepositoryImplementation({
    required FirebaseFirestore firebaseFirestore,
    required ChatService chatService,
  })  : _database = firebaseFirestore,
        _chatService = chatService;

  final FirebaseFirestore _database;
  final ChatService _chatService;

  @override
  Stream<List<Chat>> getChats({
    required String uid,
    required enums.Type userType,
  }) {
    late StreamController<List<Chat>> streamController;
    late StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
        streamSubscription;

    if (userType == enums.Type.student) {
      _maybeSendFirstReply(
        uid,
      );
    }

    streamController = StreamController<List<Chat>>(
      onListen: () {
        streamSubscription = _chatService
            .getChats(
          uid,
        )
            .listen(
          (querySnapshot) {
            final chats = querySnapshot.docs
                .map(
                  (
                    queryDocumentSnapshot,
                  ) =>
                      Chat.fromJson(
                    queryDocumentSnapshot.data(),
                  ),
                )
                .toList();
            streamController.sink.add(
              chats,
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
  Future<void> sendMessage({
    required String message,
    required String uid,
  }) async {
    final chat = Chat(
      message: message,
      isReply: false,
      deliveryStatus: enums.MessageDeliveryStatus.sending,
      sentAt: Timestamp.now(),
    );

    final chatsCollectionReference = _database
        .collection(
          usersCollection,
        )
        .doc(uid)
        .collection(
          chatsCollection,
        );

    final thisChatDocumentReference = chatsCollectionReference.doc();

    await thisChatDocumentReference.set(
      chat.toJson(),
    );

    try {
      final result = await _chatService.sendMessage(
        path: forwardSlash + dotenv.env[chatPath]!,
        queryParameters: <String, String>{
          messageKey: message,
        },
      );

      await thisChatDocumentReference.update({
        deliveryStatusField: enums.MessageDeliveryStatus.sent.name,
      });

      final reply = Chat(
        message: result.data as String,
        isReply: true,
        deliveryStatus: enums.MessageDeliveryStatus.sent,
        sentAt: Timestamp.now(),
      );

      await chatsCollectionReference.doc().set(
            reply.toJson(),
          );
    } catch (_) {
      await thisChatDocumentReference.update({
        deliveryStatusField: enums.MessageDeliveryStatus.failed.name,
      });
    }
  }

  Future<void> _maybeSendFirstReply(
    String uid,
  ) async {
    final userDocumentReference = _database
        .collection(
          usersCollection,
        )
        .doc(uid);

    final userName =
        (await userDocumentReference.get()).data()![nameField] as String;

    final chatsCollectionReference = userDocumentReference.collection(
      chatsCollection,
    );

    final chatsQuerySnapshot = await chatsCollectionReference.get();

    if (chatsQuerySnapshot.docs.isEmpty) {
      final firstReply = Chat(
        message: hi +
            whiteSpace +
            userName +
            comma +
            whiteSpace +
            firstChatBotPrompt,
        isReply: true,
        deliveryStatus: enums.MessageDeliveryStatus.sent,
        sentAt: Timestamp.now(),
      );

      await chatsCollectionReference.doc().set(
            firstReply.toJson(),
          );
    }
  }
}
