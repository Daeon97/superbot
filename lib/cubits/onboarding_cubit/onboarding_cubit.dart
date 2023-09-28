// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:superbot/resources/strings/local.dart';

part 'onboarding_state.dart';

final class OnboardingCubit extends HydratedCubit<OnboardingState> {
  OnboardingCubit()
      : super(
          const OnboardingState(
            show: true,
          ),
        );

  // ignore: avoid_setters_without_getters
  set show(
    bool show,
  ) =>
      emit(
        OnboardingState(
          show: show,
        ),
      );

  @override
  OnboardingState? fromJson(
    Map<String, dynamic> json,
  ) {
    try {
      final show = json[onboardingKey] as bool;
      return OnboardingState(
        show: show,
      );
    } catch (_) {
      return const OnboardingState(
        show: true,
      );
    }
  }

  @override
  Map<String, dynamic>? toJson(
    OnboardingState state,
  ) =>
      {
        onboardingKey: state.show,
      };
}
