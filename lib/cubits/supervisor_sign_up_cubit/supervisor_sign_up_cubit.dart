// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superbot/models/failure.dart';
import 'package:superbot/repositories/auth_repository.dart';
import 'package:superbot/utils/enums.dart' as enums;

part 'supervisor_sign_up_state.dart';

final class SupervisorSignUpCubit extends Cubit<SupervisorSignUpState> {
  SupervisorSignUpCubit(
    AuthRepository authRepository,
  )   : _authRepository = authRepository,
        super(
          const SupervisorSignUpInitialState(),
        );

  final AuthRepository _authRepository;

  Future<void> signUpSupervisor({
    required String name,
    required String email,
    required String status,
    required String password,
  }) async {
    emit(
      const SigningUpSupervisorState(),
    );

    final result = await _authRepository.signUpSupervisor(
      name: name,
      email: email,
      status: status,
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
        SupervisorSignUpFailureState(
          failure,
        ),
      );

  void _success(
    enums.Type _,
  ) =>
      emit(
        const SupervisorSignUpSuccessState(),
      );
}
