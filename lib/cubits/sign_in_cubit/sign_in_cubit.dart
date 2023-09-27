// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superbot/models/failure.dart';
import 'package:superbot/repositories/auth_repository.dart';
import 'package:superbot/resources/strings/routes.dart';
import 'package:superbot/utils/enums.dart' as enums;

part 'sign_in_state.dart';

final class SignInCubit extends Cubit<SignInState> {
  SignInCubit(
    AuthRepository authRepository,
  )   : _authRepository = authRepository,
        super(
          const SignInInitialState(),
        );

  final AuthRepository _authRepository;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(
      const SigningInState(),
    );

    final result = await _authRepository.signIn(
      email: email,
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
        SignInFailureState(
          failure,
        ),
      );

  void _success(
    enums.Type type,
  ) =>
      emit(
        SignInSuccessState(
          switch (type) {
            enums.Type.student => studentHomeScreenRoute,
            enums.Type.supervisor => supervisorHomeScreenRoute,
          },
        ),
      );
}
