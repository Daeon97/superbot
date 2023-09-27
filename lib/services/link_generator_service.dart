// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:superbot/injection_container.dart';
import 'package:superbot/resources/strings/networking.dart';
import 'package:superbot/resources/strings/routes.dart';

abstract interface class LinkGeneratorService {
  Future<Uri> buildlink(
    String uid,
  );
}

final class DynamicLinkService implements LinkGeneratorService {
  @override
  Future<Uri> buildlink(
    String uid,
  ) {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(
        dynamicLinkLink + uid + studentSignUpScreenRoute,
      ),
      uriPrefix: dynamicLinkUriPrefix,
      androidParameters: const AndroidParameters(
        packageName: packageName,
      ),
    );

    return sl<FirebaseDynamicLinks>().buildLink(
      dynamicLinkParams,
    );
  }
}
