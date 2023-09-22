// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superbot/repositories/auth_repository.dart';

part 'sign_up_state.dart';

final class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(
    AuthRepository authRepository,
  )   : _authRepository = authRepository,
        super(
          const SignUpInitialState(),
        );

  final AuthRepository _authRepository;
}
