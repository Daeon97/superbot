// ignore_for_file: public_member_api_docs

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:superbot/resources/numbers.dart';
import 'package:superbot/resources/strings/characters.dart';
import 'package:superbot/resources/strings/ui.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    required PageController pageController,
    super.key,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final ValueNotifier<bool> _obscurePasswordNotifier;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _obscurePasswordNotifier = ValueNotifier<bool>(
      true,
    );
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _obscurePasswordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: spacing,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: largeSpacing,
                  ),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      welcome,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  const SizedBox(
                    height: largeSpacing,
                  ),
                  TextFormField(
                    controller: _emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: email,
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return fieldCannotBeEmpty;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: largeSpacing,
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: _obscurePasswordNotifier,
                    builder: (_, obscurePassword, __) => TextFormField(
                      controller: _passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: password,
                        prefixIcon: const Icon(
                          Icons.password,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => switch (obscurePassword) {
                            true => _obscurePasswordNotifier.value = false,
                            false => _obscurePasswordNotifier.value = true,
                          },
                          icon: Icon(
                            switch (obscurePassword) {
                              true => Icons.lock,
                              false => Icons.lock_open,
                            },
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return fieldCannotBeEmpty;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: largeSpacing,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        signIn,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        width: largeSpacing,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            //.
                          }
                        },
                        child: const Icon(
                          Icons.arrow_forward,
                          size: extraLargeSpacing,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: extraLargeSpacing,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: dontHaveAnAccount,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const TextSpan(
                          text: whiteSpace,
                        ),
                        TextSpan(
                          text: signUp,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                widget._pageController.animateToPage(
                                  pageTwo,
                                  duration: const Duration(
                                    milliseconds: pageAnimationDurationMillis,
                                  ),
                                  curve: Curves.easeIn,
                                ),
                        ),
                        const TextSpan(
                          text: whiteSpace,
                        ),
                        TextSpan(
                          text: instead,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
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
      );
}
