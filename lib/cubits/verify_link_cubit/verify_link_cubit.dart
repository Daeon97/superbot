// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superbot/models/failure.dart';
import 'package:superbot/repositories/link_ops_repository.dart';
import 'package:superbot/resources/strings/ui.dart';

part 'verify_link_state.dart';

class VerifyLinkCubit extends Cubit<VerifyLinkState> {
  VerifyLinkCubit(
    LinkOpsRepository linkOpsRepository,
  )   : _linkOpsRepository = linkOpsRepository,
        super(
          const VerifyLinkInitialState(),
        );

  final LinkOpsRepository _linkOpsRepository;

  Future<void> verifyLink(
    String link,
  ) async {
    emit(
      const VerifyingLinkState(),
    );
    
    await Future.delayed(Duration(seconds: 5,),);

    final result = await _linkOpsRepository.verifyLink(
      link,
    );

    emit(
      switch (result) {
        true => VerifyLinkSuccessState(
            _linkOpsRepository.getUidFromLink(
              link,
            ),
          ),
        false => const VerifyLinkFailureState(
            Failure(
              invalidLink,
            ),
          ),
      },
    );
  }
}
