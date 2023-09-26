// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:superbot/injection_container.dart';
import 'package:superbot/resources/strings/characters.dart';
import 'package:superbot/resources/strings/networking.dart';
import 'package:superbot/resources/strings/routes.dart';

abstract interface class DynamicLinkService {
  Future<Uri> buildlink(
    String uid,
  );
}

final class DynamicLinkServiceImplementation implements DynamicLinkService {
  @override
  Future<Uri> buildlink(
    String uid,
  ) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(
        dynamicLinkLink + uid + studentSignUpScreenRoute + forwardSlash,
      ),
      uriPrefix: dynamicLinkUriPrefix,
      androidParameters: const AndroidParameters(
        packageName: packageName,
      ),
    );

    final dynamicLink = await sl<FirebaseDynamicLinks>().buildLink(
      dynamicLinkParams,
    );

    if (kDebugMode) {
      print('built dynamic link is $dynamicLink');
    }

    return dynamicLink;
  }
}
