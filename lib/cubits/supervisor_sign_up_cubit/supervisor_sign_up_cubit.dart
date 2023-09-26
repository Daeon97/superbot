// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superbot/repositories/auth_repository.dart';

part 'supervisor_sign_up_state.dart';

final class SupervisorSignUpCubit extends Cubit<SupervisorSignUpState> {
  SupervisorSignUpCubit(
    AuthRepository authRepository,
  )   : _authRepository = authRepository,
        super(
          const SupervisorSignUpInitialState(),
        );

  final AuthRepository _authRepository;
}
