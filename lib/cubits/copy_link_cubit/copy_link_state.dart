// ignore_for_file: public_member_api_docs

part of 'copy_link_cubit.dart';

abstract final class CopyLinkState extends Equatable {
  const CopyLinkState();
}

final class CopyLinkInitialState extends CopyLinkState {
  const CopyLinkInitialState();

  @override
  List<Object?> get props => [];
}

final class CopyingLinkState extends CopyLinkState {
  const CopyingLinkState();

  @override
  List<Object?> get props => [];
}

final class CopyLinkSuccessState extends CopyLinkState {
  const CopyLinkSuccessState();

  @override
  List<Object?> get props => [];
}
