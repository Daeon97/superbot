// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:superbot/resources/numbers.dart';
import 'package:superbot/resources/strings/assets_paths.dart';
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
                    Text(
                      introHead,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
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
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        iAmAStudent,
                      ),
                    ),
                    const SizedBox(
                      height: spacing,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        iAmASupervisor,
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
