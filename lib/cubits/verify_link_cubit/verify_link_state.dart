// ignore_for_file: public_member_api_docs

part of 'verify_link_cubit.dart';

abstract final class VerifyLinkState extends Equatable {
  const VerifyLinkState();
}

final class VerifyLinkInitialState extends VerifyLinkState {
  const VerifyLinkInitialState();

  @override
  List<Object?> get props => [];
}

final class VerifyingLinkState extends VerifyLinkState {
  const VerifyingLinkState();

  @override
  List<Object?> get props => [];
}

final class VerifyLinkSuccessState extends VerifyLinkState {
  const VerifyLinkSuccessState(
    this.supervisorUid,
  );

  final String supervisorUid;

  @override
  List<Object?> get props => [
        supervisorUid,
      ];
}

final class VerifyLinkFailureState extends VerifyLinkState {
  const VerifyLinkFailureState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
