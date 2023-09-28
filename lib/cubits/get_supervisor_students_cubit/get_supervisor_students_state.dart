// ignore_for_file: public_member_api_docs

part of 'get_supervisor_students_cubit.dart';

abstract final class GetSupervisorStudentsState extends Equatable {
  const GetSupervisorStudentsState();
}

final class GetSupervisorStudentsInitialState
    extends GetSupervisorStudentsState {
  const GetSupervisorStudentsInitialState();

  @override
  List<Object?> get props => [];
}

final class GettingSupervisorStudentsState extends GetSupervisorStudentsState {
  const GettingSupervisorStudentsState();

  @override
  List<Object?> get props => [];
}

final class GetSupervisorStudentsSuccessState
    extends GetSupervisorStudentsState {
  const GetSupervisorStudentsSuccessState(
    this.students,
  );

  final List<(Student, String)> students;

  @override
  List<Object?> get props => [
        students,
      ];
}
