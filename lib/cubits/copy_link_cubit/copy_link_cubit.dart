// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superbot/models/failure.dart';
import 'package:superbot/repositories/auth_repository.dart';
import 'package:superbot/repositories/clipboard_repository.dart';
import 'package:superbot/repositories/database_ops_repository.dart';

part 'copy_link_state.dart';

class CopyLinkCubit extends Cubit<CopyLinkState> {
  CopyLinkCubit({
    required ClipboardRepository clipboardRepository,
    required AuthRepository authRepository,
    required DatabaseOpsRepository databaseOpsRepository,
  })  : _clipboardRepository = clipboardRepository,
        _authRepository = authRepository,
        _databaseOpsRepository = databaseOpsRepository,
        super(
          const CopyLinkInitialState(),
        );

  final ClipboardRepository _clipboardRepository;
  final AuthRepository _authRepository;
  final DatabaseOpsRepository _databaseOpsRepository;

  // ignore: avoid_setters_without_getters
  Future<void> copySupervisorInviteLinkToClipboard() async {
    emit(
      const CopyingLinkState(),
    );

    final userId = _authRepository.user!.uid;

    // _clipboardRepository.data = text;

    emit(
      const CopyLinkSuccessState(),
    );
  }
}
