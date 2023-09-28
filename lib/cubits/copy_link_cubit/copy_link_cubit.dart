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
    required DatabaseOpsRepository databaseOpsRepository,
  })  : _linkOpsRepository = linkOpsRepository,
        _authRepository = authRepository,
        _databaseOpsRepository = databaseOpsRepository,
        super(
          const CopyLinkInitialState(),
        );

  final LinkOpsRepository _linkOpsRepository;
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
