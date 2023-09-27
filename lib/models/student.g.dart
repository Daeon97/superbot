// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      name: json['name'] as String,
      type: json['type'] as String,
      degreeType: json['degree_type'] as String,
      courseOfStudy: json['course_of_study'] as String,
      regNo: json['reg_no'] as String,
      supervisorId: json['supervisor_id'] as String,
      createdAt: _createdAtFromJson(json['created_at'] as Timestamp),
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'degree_type': instance.degreeType,
      'course_of_study': instance.courseOfStudy,
      'reg_no': instance.regNo,
      'supervisor_id': instance.supervisorId,
      'created_at': _createdAtToJson(instance.createdAt),
    };
