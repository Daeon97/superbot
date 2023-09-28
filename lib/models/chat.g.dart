// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      message: json['message'] as String,
      isReply: json['is_reply'] as bool,
      deliveryStatus:
          $enumDecode(_$MessageDeliveryStatusEnumMap, json['delivery_status']),
      sentAt: _sentAtFromJson(json['sent_at'] as Timestamp),
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'message': instance.message,
      'is_reply': instance.isReply,
      'delivery_status':
          _$MessageDeliveryStatusEnumMap[instance.deliveryStatus]!,
      'sent_at': _sentAtToJson(instance.sentAt),
    };

const _$MessageDeliveryStatusEnumMap = {
  MessageDeliveryStatus.sending: 'sending',
  MessageDeliveryStatus.failed: 'failed',
  MessageDeliveryStatus.sent: 'sent',
};
