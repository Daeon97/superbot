// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superbot/repositories/auth_repository.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit(
    AuthRepository authRepository,
  )   : _authRepository = authRepository,
        super(
          const SignOutInitialState(),
        );

  final AuthRepository _authRepository;

  Future<void> signOut() async {
    await _authRepository.signOut();

    emit(
      const SignOutSuccessState(),
    );
  }
}
