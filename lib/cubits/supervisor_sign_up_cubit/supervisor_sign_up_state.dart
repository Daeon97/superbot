// ignore_for_file: public_member_api_docs

part of 'supervisor_sign_up_cubit.dart';

abstract final class SupervisorSignUpState extends Equatable {
  const SupervisorSignUpState();
}

final class SupervisorSignUpInitialState extends SupervisorSignUpState {
  const SupervisorSignUpInitialState();

  @override
  List<Object?> get props => [];
}

final class SigningUpSupervisorState extends SupervisorSignUpState {
  const SigningUpSupervisorState();

  @override
  List<Object?> get props => [];
}

final class SupervisorSignUpSuccessState extends SupervisorSignUpState {
  const SupervisorSignUpSuccessState();

  @override
  List<Object?> get props => [];
}

final class SupervisorSignUpFailureState extends SupervisorSignUpState {
  const SupervisorSignUpFailureState();

  @override
  List<Object?> get props => [];
}
