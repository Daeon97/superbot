// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superbot/models/student.dart';
import 'package:superbot/repositories/auth_repository.dart';
import 'package:superbot/repositories/database_ops_repository.dart';

part 'get_supervisor_students_state.dart';

class GetSupervisorStudentsCubit extends Cubit<GetSupervisorStudentsState> {
  GetSupervisorStudentsCubit({
    required AuthRepository authRepository,
    required DatabaseOpsRepository databaseOpsRepository,
  })  : _authRepository = authRepository,
        _databaseOpsRepository = databaseOpsRepository,
        super(
          const GetSupervisorStudentsInitialState(),
        );

  final AuthRepository _authRepository;
  final DatabaseOpsRepository _databaseOpsRepository;

  StreamSubscription<List<(Student, String)>>?
      _supervisorStudentsStreamSubscription;

  Future<void> listenSupervisorStudents() async {
    emit(
      const GettingSupervisorStudentsState(),
    );

    if (_supervisorStudentsStreamSubscription != null) {
      await _supervisorStudentsStreamSubscription!.cancel();
      _supervisorStudentsStreamSubscription = null;
    }

    _supervisorStudentsStreamSubscription = _databaseOpsRepository
        .getStudents(
          _authRepository.user!.uid,
        )
        .listen(
          _supervisorStudents,
        );
  }

  Future<void> stopListeningSupervisorStudents() async {
    if (_supervisorStudentsStreamSubscription != null) {
      await _supervisorStudentsStreamSubscription!.cancel();
      _supervisorStudentsStreamSubscription = null;
    }
  }

  void _supervisorStudents(
    List<(Student, String)> students,
  ) =>
      emit(
        GetSupervisorStudentsSuccessState(
          students,
        ),
      );
}
