// ignore_for_file: public_member_api_docs

import 'package:get_it/get_it.dart';
import 'package:superbot/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:superbot/cubits/sign_up_cubit/sign_up_cubit.dart';

final sl = GetIt.I;

void registerServices() {
  sl
    // Cubits
    ..registerFactory(
      () => SignInCubit(
        sl(),
      ),
    )
    ..registerFactory(
      () => SignUpCubit(
        sl(),
      ),
    );
  //   ..registerFactory(
  //         () => TrackerModulesBloc(
  //       trackerModuleUseCase: sl(),
  //     ),
  //   )
  //   ..registerFactory(
  //     AllTrackerModulesOrOneTrackerModuleBloc.new,
  //   )
  //   ..registerFactory(
  //         () => TrackerModuleDetailBloc(
  //       trackerModuleUseCase: sl(),
  //     ),
  //   )
  //   ..registerFactory(
  //         () => TrackerModulesDetailBloc(
  //       trackerModuleUseCase: sl(),
  //     ),
  //   )
  //   ..registerFactory(
  //         () => TrackerModuleNameUpdateBloc(
  //       trackerModuleUseCase: sl(),
  //     ),
  //   )
  //   ..registerFactory(
  //         () => TrackerModuleNameGetBloc(
  //       trackerModuleUseCase: sl(),
  //     ),
  //   )
  //
  // // Use cases
  //   ..registerLazySingleton(
  //         () => TrackerModuleUseCase(
  //       trackerModuleRepository: sl(),
  //     ),
  //   )
  //   ..registerLazySingleton(
  //         () => ThemeUseCase(
  //       themeRepository: sl(),
  //     ),
  //   )
  //
  // // Repositories
  //   ..registerLazySingleton<TrackerModuleRepository>(
  //         () => TrackerModuleRepositoryImplementation(
  //       trackerModuleRemoteDataSource: sl(),
  //     ),
  //   )
  //   ..registerLazySingleton<ThemeRepository>(
  //         () => ThemeRepositoryImplementation(
  //       themeDataSource: sl(),
  //     ),
  //   )
  //
  // // Data sources
  //   ..registerLazySingleton<TrackerModuleRemoteDataSource>(
  //     TrackerModuleRemoteDataSourceImplementation.new,
  //   )
  //   ..registerLazySingleton<ThemeDataSource>(
  //     ThemeDataSourceImplementation.new,
  //   );
}
