// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get_it/get_it.dart';
import 'package:superbot/cubits/onboarding_cubit/onboarding_cubit.dart';
import 'package:superbot/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:superbot/repositories/auth_repository.dart';
import 'package:superbot/services/dynamic_link_service.dart';

final sl = GetIt.I;

void registerServices() {
  sl
    // Cubits
    ..registerFactory(
      OnboardingCubit.new,
    )
    ..registerFactory<SignInCubit>(
      () => SignInCubit(
        sl(),
      ),
    )

    // Repositories
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImplementation(
        firebaseAuth: sl(),
        firebaseFirestore: sl(),
      ),
    )

    // Services
    ..registerLazySingleton<DynamicLinkService>(
      DynamicLinkServiceImplementation.new,
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
    );
}
