// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superbot/models/chat.dart';
import 'package:superbot/repositories/auth_repository.dart';
import 'package:superbot/repositories/chat_repository.dart';
import 'package:superbot/utils/extensions.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit({
    required ChatRepository chatRepository,
    required AuthRepository authRepository,
  })  : _chatRepository = chatRepository,
        _authRepository = authRepository,
        super(
          const ChatsState(
            [],
          ),
        );

  final ChatRepository _chatRepository;
  final AuthRepository _authRepository;

  StreamSubscription<List<Chat>>? _chatsStreamSubscription;

  Future<void> listenChats() async {
    if (_chatsStreamSubscription != null) {
      await _chatsStreamSubscription!.cancel();
      _chatsStreamSubscription = null;
    }

    _chatsStreamSubscription = _chatRepository
        .getChats(
          uid: _authRepository.user!.uid,
          userType: await _authRepository.user!.type,
        )
        .listen(
          _chats,
        );
  }

  Future<void> stopListeningChats() async {
    if (_chatsStreamSubscription != null) {
      await _chatsStreamSubscription!.cancel();
      _chatsStreamSubscription = null;
    }
  }

  void _chats(
    List<Chat> chats,
  ) =>
      emit(
        ChatsState(
          chats,
        ),
      );
}
