// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superbot/models/supervisor.dart';
import 'package:superbot/repositories/auth_repository.dart';
import 'package:superbot/repositories/database_ops_repository.dart';

part 'get_student_supervisor_state.dart';

class GetStudentSupervisorCubit extends Cubit<GetStudentSupervisorState> {
  GetStudentSupervisorCubit({
    required AuthRepository authRepository,
    required DatabaseOpsRepository databaseOpsRepository,
  })  : _authRepository = authRepository,
        _databaseOpsRepository = databaseOpsRepository,
        super(
          const GetStudentSupervisorInitialState(),
        );

  final AuthRepository _authRepository;
  final DatabaseOpsRepository _databaseOpsRepository;

  Future<void> get studentSupervisor async {
    emit(
      const GettingStudentSupervisorState(),
    );
    final supervisor = await _databaseOpsRepository.getSupervisor(
      _authRepository.user!.uid,
    );

    emit(
      GetStudentSupervisorSuccessState(
        supervisor,
      ),
    );
  }
}
