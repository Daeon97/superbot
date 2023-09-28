// ignore_for_file: public_member_api_docs

part of 'chats_cubit.dart';

final class ChatsState extends Equatable {
  const ChatsState(
    this.chats,
  );

  final List<Chat> chats;

  @override
  List<Object?> get props => [
        chats,
      ];
}
