// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superbot/repositories/auth_repository.dart';
import 'package:superbot/repositories/database_ops_repository.dart';
import 'package:superbot/repositories/link_ops_repository.dart';

part 'copy_link_state.dart';

class CopyLinkCubit extends Cubit<CopyLinkState> {
  CopyLinkCubit({
    required LinkOpsRepository linkOpsRepository,
    required AuthRepository authRepository,
  })  : _linkOpsRepository = linkOpsRepository,
        _authRepository = authRepository,
        super(
          const CopyLinkInitialState(),
        );

  final LinkOpsRepository _linkOpsRepository;
  final AuthRepository _authRepository;

  Future<void> copyInviteLinkToClipboard() async {
    emit(
      const CopyingLinkState(),
    );

    await _linkOpsRepository.copyLinkToClipboard(
      _authRepository.user!.uid,
    );

    emit(
      const CopyLinkSuccessState(),
    );
  }
}
