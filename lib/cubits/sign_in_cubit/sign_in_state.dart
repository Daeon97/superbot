// ignore_for_file: public_member_api_docs

part of 'sign_in_cubit.dart';

abstract final class SignInState extends Equatable {
  const SignInState();
}

final class SignInInitialState extends SignInState {
  const SignInInitialState();

  @override
  List<Object?> get props => [];
}

final class SigningInState extends SignInState {
  const SigningInState();

  @override
  List<Object?> get props => [];
}

final class SignInSuccessState extends SignInState {
  const SignInSuccessState(
    this.route,
  );

  final String route;

  @override
  List<Object?> get props => [
        route,
      ];
}

final class SignInFailureState extends SignInState {
  const SignInFailureState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
