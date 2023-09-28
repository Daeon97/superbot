// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:superbot/resources/strings/networking.dart';
import 'package:superbot/utils/enums.dart';

part 'chat.g.dart';

Timestamp _sentAtFromJson(
  Timestamp createdAt,
) =>
    createdAt;

Timestamp _sentAtToJson(
  Timestamp createdAt,
) =>
    createdAt;

@JsonSerializable()
final class Chat {
  const Chat({
    required this.message,
    required this.isReply,
    required this.deliveryStatus,
    required this.sentAt,
  });

  factory Chat.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ChatFromJson(
        json,
      );

  final String message;

  @JsonKey(name: isReplyField)
  final bool isReply;

  @JsonKey(name: deliveryStatusField)
  final MessageDeliveryStatus deliveryStatus;

  @JsonKey(
    name: sentAtField,
    fromJson: _sentAtFromJson,
    toJson: _sentAtToJson,
  )
  final Timestamp sentAt;

  Map<String, dynamic> toJson() => _$ChatToJson(
        this,
      );
}
