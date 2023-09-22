// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superbot/repositories/auth_repository.dart';

part 'sign_in_state.dart';

final class SignInCubit extends Cubit<SignInState> {
  SignInCubit(
    AuthRepository authRepository,
  )   : _authRepository = authRepository,
        super(
          const SignInInitialState(),
        );

  final AuthRepository _authRepository;
}
