// ignore_for_file: public_member_api_docs

part of 'sign_out_cubit.dart';

abstract final class SignOutState extends Equatable {
  const SignOutState();
}

final class SignOutInitialState extends SignOutState {
  const SignOutInitialState();

  @override
  List<Object> get props => [];
}

final class SignOutSuccessState extends SignOutState {
  const SignOutSuccessState();

  @override
  List<Object> get props => [];
}
