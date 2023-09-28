// ignore_for_file: public_member_api_docs

part of 'chats_cubit.dart';

abstract final class ChatsState extends Equatable {
  const ChatsState();
}

final class ChatsInitialState extends ChatsState {
  const ChatsInitialState();

  @override
  List<Object?> get props => [];
}

final class LoadedChatsState extends ChatsState {
  const LoadedChatsState(
    this.chats,
  );

  final List<Chat> chats;

  @override
  List<Object?> get props => [
        chats,
      ];
}
