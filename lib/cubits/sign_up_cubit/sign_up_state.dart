// ignore_for_file: public_member_api_docs

part of 'sign_up_cubit.dart';

abstract final class SignUpState extends Equatable {
  const SignUpState();
}

final class SignUpInitialState extends SignUpState {
  const SignUpInitialState();

  @override
  List<Object?> get props => [];
}
