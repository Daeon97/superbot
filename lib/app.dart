// ignore_for_file: public_member_api_docs, strict_raw_type

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superbot/cubits/chats_cubit/chats_cubit.dart';
import 'package:superbot/cubits/copy_link_cubit/copy_link_cubit.dart';
import 'package:superbot/cubits/get_student_supervisor_cubit/get_student_supervisor_cubit.dart';
import 'package:superbot/cubits/get_supervisor_students_cubit/get_supervisor_students_cubit.dart';
import 'package:superbot/cubits/onboarding_cubit/onboarding_cubit.dart';
import 'package:superbot/cubits/send_message_cubit/send_message_cubit.dart';
import 'package:superbot/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:superbot/cubits/sign_out_cubit/sign_out_cubit.dart';
import 'package:superbot/cubits/student_sign_up_cubit/student_sign_up_cubit.dart';
import 'package:superbot/cubits/supervisor_sign_up_cubit/supervisor_sign_up_cubit.dart';
import 'package:superbot/cubits/verify_link_cubit/verify_link_cubit.dart';
import 'package:superbot/injection_container.dart';
import 'package:superbot/resources/colors.dart';
import 'package:superbot/resources/strings/routes.dart';
import 'package:superbot/utils/enums.dart' as enums;
import 'package:superbot/utils/extensions.dart';
import 'package:superbot/views/screens/supervisor_chat_screen.dart';
import 'package:superbot/views/screens/loading_route_screen.dart';
import 'package:superbot/views/screens/onboarding_screen.dart';
import 'package:superbot/views/screens/sign_in_screen.dart';
import 'package:superbot/views/screens/student_chat_screen.dart';
import 'package:superbot/views/screens/student_sign_up_screen.dart';
import 'package:superbot/views/screens/supervisor_home_screen.dart';
import 'package:superbot/views/screens/supervisor_sign_up_screen.dart';

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
          onGenerateRoute: _routes,
        ),
      );

  List<BlocProvider> get _providers => [
        BlocProvider<OnboardingCubit>(
          create: (_) => sl(),
        ),
        BlocProvider<SignInCubit>(
          create: (_) => sl(),
        ),
        BlocProvider<StudentSignUpCubit>(
          create: (_) => sl(),
        ),
        BlocProvider<SupervisorSignUpCubit>(
          create: (_) => sl(),
        ),
        BlocProvider<CopyLinkCubit>(
          create: (_) => sl(),
        ),
        BlocProvider<ChatsCubit>(
          create: (_) => sl(),
        ),
        BlocProvider<VerifyLinkCubit>(
          create: (_) => sl(),
        ),
        BlocProvider<SendMessageCubit>(
          create: (_) => sl(),
        ),
        BlocProvider<SignOutCubit>(
          create: (_) => sl(),
        ),
        BlocProvider<GetSupervisorStudentsCubit>(
          create: (_) => sl(),
        ),
        BlocProvider<GetStudentSupervisorCubit>(
          create: (_) => sl(),
        ),
      ];

  Route _routes(
    RouteSettings settings,
  ) =>
      MaterialPageRoute(
        builder: (context) => switch (settings.name) {
          defaultScreenRoute => switch (
                context.read<OnboardingCubit>().state.show) {
              false when sl<FirebaseAuth>().currentUser == null =>
                const SignInScreen(),
              false when sl<FirebaseAuth>().currentUser != null =>
                FutureBuilder(
                  future: sl<FirebaseAuth>().currentUser!.type,
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return switch (snapshot.data!) {
                        enums.Type.student => const StudentChatScreen(),
                        enums.Type.supervisor => const SupervisorHomeScreen(),
                      };
                    }
                    return const LoadingRouteScreen();
                  },
                ),
              _ => const OnboardingScreen(),
            },
          onboardingScreenRoute => const OnboardingScreen(),
          signInScreenRoute => const SignInScreen(),
          studentSignUpScreenRoute => const StudentSignUpScreen(),
          studentChatScreenRoute => const StudentChatScreen(),
          supervisorSignUpScreenRoute => const SupervisorSignUpScreen(),
          supervisorHomeScreenRoute => const SupervisorHomeScreen(),
          supervisorChatScreenRoute => SupervisorChatScreen(
              uid: (settings.arguments! as Set<String>).first,
              name: (settings.arguments! as Set<String>).last,
            ),
          _ => Container(),
        },
      );
}
