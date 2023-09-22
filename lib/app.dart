// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superbot/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:superbot/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:superbot/injection_container.dart';
import 'package:superbot/resources/colors.dart';
import 'package:superbot/resources/strings/routes.dart';
import 'package:superbot/views/screens/auth_screen.dart';
import 'package:superbot/views/screens/chat_screen.dart';
import 'package:superbot/views/screens/onboarding_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: _providers,
        child: MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: baseColor,
            ),
          ),
          routes: {
            defaultScreenRoute: (_) => const AuthScreen(),
            onboardingScreenRoute: (_) => const OnboardingScreen(),
            authScreenRoute: (_) => const AuthScreen(),
            chatScreenRoute: (_) => const ChatScreen(),
          },
        ),
      );

  List<BlocProvider> get _providers => [
        BlocProvider<SignInCubit>(
          create: (_) => sl(),
        ),
        BlocProvider<SignUpCubit>(
          create: (_) => sl(),
        ),
      ];
}
