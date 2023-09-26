// ignore_for_file: public_member_api_docs

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:superbot/app.dart';
import 'package:superbot/firebase_options.dart';
import 'package:superbot/injection_container.dart';

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

  // await dotenv.load();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  registerServices();
}

Future<void> _handleDynamicLinks() async {
  final initialLink = await sl<FirebaseDynamicLinks>().getInitialLink();

  if (initialLink != null) {
    if (kDebugMode) {
      print('if block initial link is ${initialLink.link}');
    }
  }

  if (kDebugMode) {
    print('under if block initial link is ${initialLink?.link}');
  }

  sl<FirebaseDynamicLinks>().onLink.listen(
    (dynamicLinkData) {
      if (kDebugMode) {
        print('dynamic link data is ${dynamicLinkData.link}');
      }
    },
  );
}
