// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get_it/get_it.dart';
import 'package:superbot/cubits/chats_cubit/chats_cubit.dart';
import 'package:superbot/cubits/copy_link_cubit/copy_link_cubit.dart';
import 'package:superbot/cubits/get_supervisor_students_cubit/get_supervisor_students_cubit.dart';
import 'package:superbot/cubits/onboarding_cubit/onboarding_cubit.dart';
import 'package:superbot/cubits/send_message_cubit/send_message_cubit.dart';
import 'package:superbot/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:superbot/cubits/sign_out_cubit/sign_out_cubit.dart';
import 'package:superbot/cubits/student_sign_up_cubit/student_sign_up_cubit.dart';
import 'package:superbot/cubits/supervisor_sign_up_cubit/supervisor_sign_up_cubit.dart';
import 'package:superbot/cubits/verify_link_cubit/verify_link_cubit.dart';
import 'package:superbot/repositories/auth_repository.dart';
import 'package:superbot/repositories/chat_repository.dart';
import 'package:superbot/repositories/database_ops_repository.dart';
import 'package:superbot/repositories/link_ops_repository.dart';
import 'package:superbot/resources/strings/local.dart';
import 'package:superbot/resources/strings/networking.dart';
import 'package:superbot/services/chat_service.dart';
import 'package:superbot/services/clipboard_service.dart';
import 'package:superbot/services/database_ops_service.dart';
import 'package:superbot/services/link_generator_service.dart';
import 'package:superbot/utils/clients/http_client.dart';

final sl = GetIt.I;

void registerServices() {
  sl
    // Cubits
    ..registerFactory<OnboardingCubit>(
      OnboardingCubit.new,
    )
    ..registerFactory<SignInCubit>(
      () => SignInCubit(
        sl(),
      ),
    )
    ..registerFactory<StudentSignUpCubit>(
      () => StudentSignUpCubit(
        sl(),
      ),
    )
    ..registerFactory<SupervisorSignUpCubit>(
      () => SupervisorSignUpCubit(
        sl(),
      ),
    )
    ..registerFactory<CopyLinkCubit>(
      () => CopyLinkCubit(
        linkOpsRepository: sl(),
        authRepository: sl(),
        databaseOpsRepository: sl(),
      ),
    )
    ..registerFactory<ChatsCubit>(
      () => ChatsCubit(
        chatRepository: sl(),
        authRepository: sl(),
      ),
    )
    ..registerFactory<VerifyLinkCubit>(
      () => VerifyLinkCubit(
        sl(),
      ),
    )
    ..registerFactory<SendMessageCubit>(
      () => SendMessageCubit(
        chatRepository: sl(),
        authRepository: sl(),
      ),
    )
    ..registerFactory<SignOutCubit>(
      () => SignOutCubit(
        sl(),
      ),
    )
    ..registerFactory<GetSupervisorStudentsCubit>(
      () => GetSupervisorStudentsCubit(
        authRepository: sl(),
        databaseOpsRepository: sl(),
      ),
    )

    // Repositories
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImplementation(
        firebaseAuth: sl(),
        firebaseFirestore: sl(),
        linkGeneratorService: sl(),
      ),
    )
    ..registerLazySingleton<LinkOpsRepository>(
      () => LinkOpsRepositoryImplementation(
        linkGeneratorService: sl(),
        clipboardService: sl(),
        firebaseFirestore: sl(),
      ),
    )
    ..registerLazySingleton<DatabaseOpsRepository>(
      () => DatabaseOpsRepositoryImplementation(
        databaseOpsService: sl(),
        firebaseFirestore: sl(),
      ),
    )
    ..registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImplementation(
        firebaseFirestore: sl(),
        chatService: sl(),
      ),
    )

    // Services
    ..registerLazySingleton<LinkGeneratorService>(
      DynamicLinkService.new,
    )
    ..registerLazySingleton<ClipboardService>(
      ClipboardServiceImplementation.new,
    )
    ..registerLazySingleton<ChatService>(
      () => ChatServiceImplementation(
        httpClient: sl.get(
          instanceName: forChatsInstanceName,
        ),
        firebaseFirestore: sl(),
      ),
    )
    ..registerLazySingleton<DatabaseOpsService>(
      () => DatabaseOpsServiceImplementation(
        sl(),
      ),
    )

    // Clients
    ..registerLazySingleton(
      () => HttpClient(
        sl.get(
          instanceName: chatBaseUrlInstanceName,
        ),
      ),
      instanceName: forChatsInstanceName,
    )

    // External
    ..registerLazySingleton<FirebaseAuth>(
      () => FirebaseAuth.instance,
    )
    ..registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    )
    ..registerLazySingleton<FirebaseDynamicLinks>(
      () => FirebaseDynamicLinks.instance,
    )

    // Primitives
    ..registerLazySingleton(
      () => chatBaseUrl,
      instanceName: chatBaseUrlInstanceName,
    );
}
