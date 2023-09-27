// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superbot/cubits/onboarding_cubit/onboarding_cubit.dart';
import 'package:superbot/resources/colors.dart';
import 'package:superbot/resources/numbers.dart';
import 'package:superbot/resources/strings/assets_paths.dart';
import 'package:superbot/resources/strings/characters.dart';
import 'package:superbot/resources/strings/routes.dart';
import 'package:superbot/resources/strings/ui.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: spacing,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: largeSpacing,
                    ),
                    Image.asset(
                      welcomeIllustrationPath,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: introHead,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const TextSpan(
                            text: tabSpace,
                          ),
                          TextSpan(
                            text: appName,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  color: baseColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: smallSpacing,
                    ),
                    Text(
                      introSub,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: largeSpacing,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height /
                          onboardingSpacerDivider,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll<Color>(
                          baseColor,
                        ),
                        shape: MaterialStatePropertyAll<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(
                              buttonBorderRadius,
                            ),
                          ),
                        ),
                        padding:
                            const MaterialStatePropertyAll<EdgeInsetsGeometry>(
                          EdgeInsetsDirectional.symmetric(
                            vertical: spacing,
                          ),
                        ),
                      ),
                      onPressed: () {
                        context.read<OnboardingCubit>().show = false;
                        Navigator.of(context).pushReplacementNamed(
                          signInScreenRoute,
                        );
                      },
                      child: Center(
                        child: Text(
                          getStarted,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: largeSpacing,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
