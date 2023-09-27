// ignore_for_file: public_member_api_docs

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:superbot/app.dart';
import 'package:superbot/firebase_options.dart';
import 'package:superbot/injection_container.dart';
import 'package:superbot/resources/numbers.dart';
import 'package:superbot/resources/strings/characters.dart';
import 'package:superbot/resources/strings/local.dart';

void main() => _init().then(
      (_) => _handleDynamicLinks().then(
        (__) => runApp(
          const App(),
        ),
      ),
    );

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  registerServices();
}

Future<Map<String, String>?> _handleDynamicLinks() async {
  Map<String, String>? deepLink;

  final initialLink = await sl<FirebaseDynamicLinks>().getInitialLink();

  if (initialLink != null) {
    final linkSegments = initialLink.link.pathSegments;
    deepLink = {
      supervisorId: linkSegments[zero],
      route: forwardSlash + linkSegments[one],
    };
  }

  return deepLink;
}
