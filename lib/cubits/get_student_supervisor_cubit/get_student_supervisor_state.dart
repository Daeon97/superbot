// ignore_for_file: public_member_api_docs

part of 'get_student_supervisor_cubit.dart';

abstract final class GetStudentSupervisorState extends Equatable {
  const GetStudentSupervisorState();
}

final class GetStudentSupervisorInitialState extends GetStudentSupervisorState {
  const GetStudentSupervisorInitialState();

  @override
  List<Object?> get props => [];
}

final class GettingStudentSupervisorState extends GetStudentSupervisorState {
  const GettingStudentSupervisorState();

  @override
  List<Object?> get props => [];
}

final class GetStudentSupervisorSuccessState extends GetStudentSupervisorState {
  const GetStudentSupervisorSuccessState(
    this.supervisor,
  );

  final Supervisor supervisor;

  @override
  List<Object?> get props => [
        supervisor,
      ];
}
