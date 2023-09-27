// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:superbot/resources/strings/networking.dart';

part 'student.g.dart';

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
final class Student {
  const Student({
    required this.name,
    required this.type,
    required this.degreeType,
    required this.courseOfStudy,
    required this.regNo,
    required this.supervisorId,
    required this.createdAt,
  });

  factory Student.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$StudentFromJson(json);

  final String name;
  final String type;

  @JsonKey(name: degreeTypeField)
  final String degreeType;

  @JsonKey(name: courseOfStudyField)
  final String courseOfStudy;

  @JsonKey(name: regNoField)
  final String regNo;

  @JsonKey(name: supervisorIdField)
  final String supervisorId;

  @JsonKey(
    name: createdAtField,
    fromJson: _createdAtFromJson,
    toJson: _createdAtToJson,
  )
  final Timestamp createdAt;

  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
