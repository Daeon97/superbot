// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:flutter/services.dart';

abstract interface class ClipboardService {
  Future<void> setData(
    String text,
  );
}

final class ClipboardServiceImplementation implements ClipboardService {
  @override
  Future<void> setData(
    String text,
  ) =>
      Clipboard.setData(
        ClipboardData(
          text: text,
        ),
      );
}
