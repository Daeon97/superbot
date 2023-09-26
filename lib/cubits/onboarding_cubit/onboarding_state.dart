// ignore_for_file: public_member_api_docs

part of 'onboarding_cubit.dart';

final class OnboardingState extends Equatable {
  const OnboardingState({
    required this.show,
  });

  final bool show;

  @override
  List<Object?> get props => [
    show,
  ];
}
