// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superbot/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:superbot/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:superbot/injection_container.dart';
import 'package:superbot/resources/colors.dart';
import 'package:superbot/resources/strings/routes.dart';
import 'package:superbot/views/screens/student_sign_up_screen.dart';
import 'package:superbot/views/screens/supervisor_sign_up_screen.dart';
import 'package:superbot/views/screens/chat_screen.dart';
import 'package:superbot/views/screens/onboarding_screen.dart';
import 'package:superbot/views/screens/sign_in_screen.dart';

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
              // brightness: Brightness.dark,
            ),
          ),
          routes: {
            defaultScreenRoute: (_) => const SignInScreen(),
            onboardingScreenRoute: (_) => const OnboardingScreen(),
            signInScreenRoute: (_) => const SignInScreen(),
            supervisorSignUpScreenRoute: (_) => const SupervisorSignUpScreen(),
            studentSignUpScreenRoute: (_) => const StudentSignUpScreen(),
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
