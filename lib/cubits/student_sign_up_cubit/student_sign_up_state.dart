// ignore_for_file: public_member_api_docs

part of 'student_sign_up_cubit.dart';

abstract final class StudentSignUpState extends Equatable {
  const StudentSignUpState();
}

final class StudentSignUpInitialState extends StudentSignUpState {
  const StudentSignUpInitialState();

  @override
  List<Object?> get props => [];
}

final class SigningUpStudentState extends StudentSignUpState {
  const SigningUpStudentState();

  @override
  List<Object?> get props => [];
}

final class StudentSignUpSuccessState extends StudentSignUpState {
  const StudentSignUpSuccessState();

  @override
  List<Object?> get props => [];
}

final class StudentSignUpFailureState extends StudentSignUpState {
  const StudentSignUpFailureState();

  @override
  List<Object?> get props => [];
}
