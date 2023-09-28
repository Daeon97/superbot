// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:superbot/resources/strings/local.dart';

final class TimeUtil {
  static String computeDayMonthYear(
    Timestamp timestamp,
  ) =>
      DateFormat(dateFormatPattern).format(
        DateTime.fromMillisecondsSinceEpoch(
          timestamp.millisecondsSinceEpoch,
        ),
      );
}
