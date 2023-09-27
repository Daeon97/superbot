// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supervisor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Supervisor _$SupervisorFromJson(Map<String, dynamic> json) => Supervisor(
      name: json['name'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      inviteLink: json['invite_link'] as String,
      createdAt: _createdAtFromJson(json['created_at'] as Timestamp),
    );

Map<String, dynamic> _$SupervisorToJson(Supervisor instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'status': instance.status,
      'invite_link': instance.inviteLink,
      'created_at': _createdAtToJson(instance.createdAt),
    };
