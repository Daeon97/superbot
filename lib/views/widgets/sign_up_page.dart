// ignore_for_file: public_member_api_docs

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:superbot/resources/numbers.dart';
import 'package:superbot/resources/strings/characters.dart';
import 'package:superbot/resources/strings/ui.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    required PageController pageController,
    super.key,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final ValueNotifier<String?> _degreeTypeNotifier;
  late final TextEditingController _courseOfStudyController;
  late final TextEditingController _regNoController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final ValueNotifier<bool> _obscurePasswordNotifier;
  late final ValueNotifier<bool> _obscureConfirmPasswordNotifier;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _degreeTypeNotifier = ValueNotifier<String?>(
      null,
    );
    _courseOfStudyController = TextEditingController();
    _regNoController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _obscurePasswordNotifier = ValueNotifier<bool>(
      true,
    );
    _obscureConfirmPasswordNotifier = ValueNotifier<bool>(
      true,
    );
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _degreeTypeNotifier.dispose();
    _courseOfStudyController.dispose();
    _regNoController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _obscurePasswordNotifier.dispose();
    _obscureConfirmPasswordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
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
                    createAccount,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                const SizedBox(
                  height: largeSpacing,
                ),
                TextFormField(
                  controller: _nameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: name,
                    prefixIcon: Icon(
                      Icons.person,
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
                TextFormField(
                  controller: _emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
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
                ValueListenableBuilder<String?>(
                  valueListenable: _degreeTypeNotifier,
                  builder: (_, degreeTypeNotifierValue, __) =>
                      DropdownButtonFormField<String>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    value: degreeTypeNotifierValue,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: degreeType,
                      prefixIcon: Icon(
                        Icons.school,
                      ),
                    ),
                    items: List<DropdownMenuItem<String>>.generate(
                      degreeTypeDropdownOptionsLength,
                      (index) => DropdownMenuItem<String>(
                        value: switch (index) {
                          degreeTypeFirstDropdownItemIndex => undergraduate,
                          _ => postgraduate,
                        },
                        child: Text(
                          switch (index) {
                            degreeTypeFirstDropdownItemIndex => undergraduate,
                            _ => postgraduate,
                          },
                        ),
                      ),
                    ),
                    onChanged: (value) {},
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
                TextFormField(
                  controller: _courseOfStudyController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: courseOfStudy,
                    prefixIcon: Icon(
                      Icons.book,
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
                TextFormField(
                  controller: _regNoController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: regNo,
                    prefixIcon: Icon(
                      Icons.app_registration,
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
                      } else if (value!.isNotEmpty) {
                        if (value != _confirmPasswordController.text) {
                          return passwordMismatch;
                        } else if (value.length < acceptablePasswordLength) {
                          return passwordTooShort;
                        }

                        return null;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: largeSpacing,
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _obscureConfirmPasswordNotifier,
                  builder: (_, obscureConfirmPassword, __) => TextFormField(
                    controller: _confirmPasswordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    obscureText: obscureConfirmPassword,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: confirmPassword,
                      prefixIcon: const Icon(
                        Icons.password,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () => switch (obscureConfirmPassword) {
                          true => _obscureConfirmPasswordNotifier.value = false,
                          false => _obscureConfirmPasswordNotifier.value = true,
                        },
                        icon: Icon(
                          switch (obscureConfirmPassword) {
                            true => Icons.lock,
                            false => Icons.lock_open,
                          },
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return fieldCannotBeEmpty;
                      } else if (value!.isNotEmpty) {
                        if (value != _passwordController.text) {
                          return passwordMismatch;
                        }

                        return null;
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
                      signUp,
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
                        text: alreadyHaveAnAccount,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const TextSpan(
                        text: whiteSpace,
                      ),
                      TextSpan(
                        text: signIn,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => widget._pageController.animateToPage(
                                pageOne,
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
      );
}
