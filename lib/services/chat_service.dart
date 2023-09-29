// ignore_for_file: public_member_api_docs, strict_raw_type

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:superbot/resources/strings/networking.dart';
import 'package:superbot/utils/clients/http_client.dart';
import 'package:superbot/utils/enums.dart';

abstract interface class ChatService {
  Stream<QuerySnapshot<Map<String, dynamic>>> getChats(
    String uid,
  );

  Future<Response> sendMessage({
    required String path,
    required Map<String, dynamic> queryParameters,
  });
}

final class ChatServiceImplementation implements ChatService {
  const ChatServiceImplementation({
    required HttpClient httpClient,
    required FirebaseFirestore firebaseFirestore,
  })  : _httpClient = httpClient,
        _database = firebaseFirestore;

  final HttpClient _httpClient;
  final FirebaseFirestore _database;

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getChats(
    String uid,
  ) =>
      _database
          .collection(
            usersCollection,
          )
          .doc(uid)
          .collection(
            chatsCollection,
          )
          .orderBy(
            sentAtField,
          )
          .snapshots();

  @override
  Future<Response> sendMessage({
    required String path,
    required Map<String, dynamic> queryParameters,
  }) =>
      _httpClient.request(
        requestMethod: RequestMethod.post,
        path: path,
        queryParameters: queryParameters,
      );
}
