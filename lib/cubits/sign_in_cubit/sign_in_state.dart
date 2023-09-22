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
