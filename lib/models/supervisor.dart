// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:superbot/resources/strings/networking.dart';

part 'supervisor.g.dart';

Timestamp _createdAtFromJson(
  Timestamp createdAt,
) =>
    createdAt;

Map<String, dynamic> _createdAtToJson(
  Timestamp createdAt,
) =>
    {
      createdAtField: createdAt,
    };

@JsonSerializable()
final class Supervisor {
  const Supervisor({
    required this.name,
    required this.type,
    required this.status,
    required this.inviteLink,
    required this.createdAt,
  });

  factory Supervisor.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SupervisorFromJson(json);

  final String name;
  final String type;
  final String status;

  @JsonKey(name: inviteLinkField)
  final String inviteLink;

  @JsonKey(
    name: createdAtField,
    fromJson: _createdAtFromJson,
    toJson: _createdAtToJson,
  )
  final Timestamp createdAt;

  Map<String, dynamic> toJson() => _$SupervisorToJson(this);
}
