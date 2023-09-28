// ignore_for_file: public_member_api_docs

part of 'send_message_cubit.dart';

abstract final class SendMessageState extends Equatable {
  const SendMessageState();
}

final class SendMessageInitialState extends SendMessageState {
  const SendMessageInitialState();

  @override
  List<Object?> get props => [];
}

final class SendingMessageState extends SendMessageState {
  const SendingMessageState();

  @override
  List<Object?> get props => [];
}

final class SendMessageSuccessState extends SendMessageState {
  const SendMessageSuccessState();

  @override
  List<Object?> get props => [];
}
