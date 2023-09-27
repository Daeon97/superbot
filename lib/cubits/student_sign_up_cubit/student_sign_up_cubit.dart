// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superbot/models/failure.dart';
import 'package:superbot/repositories/auth_repository.dart';
import 'package:superbot/utils/enums.dart' as enums;

part 'student_sign_up_state.dart';

final class StudentSignUpCubit extends Cubit<StudentSignUpState> {
  StudentSignUpCubit(
    AuthRepository authRepository,
  )   : _authRepository = authRepository,
        super(
          const StudentSignUpInitialState(),
        );

  final AuthRepository _authRepository;

  Future<void> signUpStudent({
    required String name,
    required String email,
    required String degreeType,
    required String courseOfStudy,
    required String regNo,
    required String supervisorUid,
    required String password,
  }) async {
    emit(
      const SigningUpStudentState(),
    );

    final result = await _authRepository.signUpStudent(
      name: name,
      email: email,
      degreeType: degreeType,
      courseOfStudy: courseOfStudy,
      regNo: regNo,
      supervisorUid: supervisorUid,
      password: password,
    );

    result.fold(
      _failure,
      _success,
    );
  }

  void _failure(
    Failure failure,
  ) =>
      emit(
        StudentSignUpFailureState(
          failure,
        ),
      );

  void _success(
    enums.Type _,
  ) =>
      emit(
        const StudentSignUpSuccessState(),
      );
}
