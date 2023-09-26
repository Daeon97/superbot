// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superbot/repositories/auth_repository.dart';

part 'student_sign_up_state.dart';

final class StudentSignUpCubit extends Cubit<StudentSignUpState> {
  StudentSignUpCubit(
    AuthRepository authRepository,
  )   : _authRepository = authRepository,
        super(
          const StudentSignUpInitialState(),
        );

  final AuthRepository _authRepository;
}
