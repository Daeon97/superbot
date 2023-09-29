// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superbot/repositories/auth_repository.dart';
import 'package:superbot/repositories/chat_repository.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit({
    required ChatRepository chatRepository,
    required AuthRepository authRepository,
  })  : _chatRepository = chatRepository,
        _authRepository = authRepository,
        super(
          const SendMessageInitialState(),
        );

  final ChatRepository _chatRepository;
  final AuthRepository _authRepository;

  Future<void> sendMessage(
    String message,
  ) async {
    emit(
      const SendingMessageState(),
    );

    await _chatRepository.sendMessage(
      message: message,
      uid: _authRepository.user!.uid,
    );

    emit(
      const SendMessageSuccessState(),
    );
  }
}
