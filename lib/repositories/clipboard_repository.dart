// ignore_for_file: public_member_api_docs, avoid_setters_without_getters, one_member_abstracts

import 'package:superbot/services/clipboard_service.dart';

abstract interface class ClipboardRepository {
  Future<void> setData(
    String text,
  );
}

final class ClipboardRepositoryImplementation implements ClipboardRepository {
  const ClipboardRepositoryImplementation(
    ClipboardService clipboardService,
  ) : _clipboardService = clipboardService;

  final ClipboardService _clipboardService;

  @override
  Future<void> setData(
    String text,
  ) =>
      _clipboardService.setData(
        text,
      );
}
