// ignore_for_file: public_member_api_docs

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superbot/cubits/supervisor_sign_up_cubit/supervisor_sign_up_cubit.dart';
import 'package:superbot/resources/colors.dart';
import 'package:superbot/resources/numbers.dart';
import 'package:superbot/resources/strings/characters.dart';
import 'package:superbot/resources/strings/routes.dart';
import 'package:superbot/resources/strings/ui.dart';

class SupervisorSignUpScreen extends StatefulWidget {
  const SupervisorSignUpScreen({super.key});

  @override
  State<SupervisorSignUpScreen> createState() => _SupervisorSignUpScreenState();
}

class _SupervisorSignUpScreenState extends State<SupervisorSignUpScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final ValueNotifier<String?> _statusNotifier;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final ValueNotifier<bool> _obscurePasswordNotifier;
  late final ValueNotifier<bool> _obscureConfirmPasswordNotifier;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _statusNotifier = ValueNotifier<String?>(
      null,
    );
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
    _statusNotifier.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _obscurePasswordNotifier.dispose();
    _obscureConfirmPasswordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<SupervisorSignUpCubit, SupervisorSignUpState>(
        listener: (_, supervisorSignUpState) {
          if (supervisorSignUpState is SupervisorSignUpFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  supervisorSignUpState.failure.reason,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                ),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          } else if (supervisorSignUpState is SupervisorSignUpSuccessState) {
            Navigator.of(context).pushReplacementNamed(
              supervisorHomeScreenRoute,
            );
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: WillPopScope(
              onWillPop: () async {
                await Navigator.of(context).pushReplacementNamed(
                  signInScreenRoute,
                );
                return true;
              },
              child: Center(
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
                              createAccount,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                          const SizedBox(
                            height: largeSpacing,
                          ),
                          BlocBuilder<SupervisorSignUpCubit,
                              SupervisorSignUpState>(
                            builder: (_, supervisorSignUpState) =>
                                TextFormField(
                              controller: _nameController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              enabled: supervisorSignUpState
                                  is! SigningUpSupervisorState,
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
                          ),
                          const SizedBox(
                            height: largeSpacing,
                          ),
                          BlocBuilder<SupervisorSignUpCubit,
                              SupervisorSignUpState>(
                            builder: (_, supervisorSignUpState) =>
                                TextFormField(
                              controller: _emailController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              enabled: supervisorSignUpState
                                  is! SigningUpSupervisorState,
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
                          ),
                          const SizedBox(
                            height: largeSpacing,
                          ),
                          BlocBuilder<SupervisorSignUpCubit,
                              SupervisorSignUpState>(
                            builder: (_, supervisorSignUpState) =>
                                ValueListenableBuilder<String?>(
                              valueListenable: _statusNotifier,
                              builder: (_, statusNotifierValue, __) =>
                                  DropdownButtonFormField<String>(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                value: statusNotifierValue,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: status,
                                  prefixIcon: Icon(
                                    Icons.supervisor_account,
                                  ),
                                ),
                                items: List<DropdownMenuItem<String>>.generate(
                                  statusDropdownOptionsLength,
                                  (index) => DropdownMenuItem<String>(
                                    value: switch (index) {
                                      statusFirstDropdownItemIndex =>
                                        supervisor,
                                      _ => coSupervisor,
                                    },
                                    child: Text(
                                      switch (index) {
                                        statusFirstDropdownItemIndex =>
                                          supervisor,
                                        _ => coSupervisor,
                                      },
                                    ),
                                  ),
                                ),
                                onChanged: supervisorSignUpState
                                        is! SigningUpSupervisorState
                                    ? (value) => _statusNotifier.value = value
                                    : null,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return fieldCannotBeEmpty;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: largeSpacing,
                          ),
                          BlocBuilder<SupervisorSignUpCubit,
                              SupervisorSignUpState>(
                            builder: (_, supervisorSignUpState) =>
                                ValueListenableBuilder<bool>(
                              valueListenable: _obscurePasswordNotifier,
                              builder: (_, obscurePassword, __) =>
                                  TextFormField(
                                controller: _passwordController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                obscureText: obscurePassword,
                                enabled: supervisorSignUpState
                                    is! SigningUpSupervisorState,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: password,
                                  prefixIcon: const Icon(
                                    Icons.password,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () => switch (obscurePassword) {
                                      true => _obscurePasswordNotifier.value =
                                          false,
                                      false => _obscurePasswordNotifier.value =
                                          true,
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
                                    if (value !=
                                        _confirmPasswordController.text) {
                                      return passwordMismatch;
                                    } else if (value.length <
                                        acceptablePasswordLength) {
                                      return passwordTooShort;
                                    }

                                    return null;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: largeSpacing,
                          ),
                          BlocBuilder<SupervisorSignUpCubit,
                              SupervisorSignUpState>(
                            builder: (_, supervisorSignUpState) =>
                                ValueListenableBuilder<bool>(
                              valueListenable: _obscureConfirmPasswordNotifier,
                              builder: (_, obscureConfirmPassword, __) =>
                                  TextFormField(
                                controller: _confirmPasswordController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                obscureText: obscureConfirmPassword,
                                enabled: supervisorSignUpState
                                    is! SigningUpSupervisorState,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: confirmPassword,
                                  prefixIcon: const Icon(
                                    Icons.password,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () =>
                                        switch (obscureConfirmPassword) {
                                      true => _obscureConfirmPasswordNotifier
                                          .value = false,
                                      false => _obscureConfirmPasswordNotifier
                                          .value = true,
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
                          ),
                          const SizedBox(
                            height: largeSpacing,
                          ),
                          BlocBuilder<SupervisorSignUpCubit,
                              SupervisorSignUpState>(
                            builder: (_, supervisorSignUpState) =>
                                ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    const MaterialStatePropertyAll<Color>(
                                  baseColor,
                                ),
                                shape: MaterialStatePropertyAll<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(
                                      buttonBorderRadius,
                                    ),
                                  ),
                                ),
                                padding: const MaterialStatePropertyAll<
                                    EdgeInsetsGeometry>(
                                  EdgeInsetsDirectional.symmetric(
                                    vertical: spacing,
                                  ),
                                ),
                              ),
                              onPressed: supervisorSignUpState
                                      is! SigningUpSupervisorState
                                  ? () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        context
                                            .read<SupervisorSignUpCubit>()
                                            .signUpSupervisor(
                                              name: _nameController.text,
                                              email: _emailController.text,
                                              status: _statusNotifier.value!,
                                              password:
                                                  _passwordController.text,
                                            );
                                      }
                                    }
                                  : null,
                              child: Center(
                                child: supervisorSignUpState
                                        is! SigningUpSupervisorState
                                    ? Text(
                                        signUp,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                            ),
                                      )
                                    : SizedBox(
                                        height:
                                            circularProgressInButtonWidthAndHeight,
                                        width:
                                            circularProgressInButtonWidthAndHeight,
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: largeSpacing,
                          ),
                          BlocBuilder<SupervisorSignUpCubit,
                              SupervisorSignUpState>(
                            builder: (_, supervisorSignUpState) => RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: alreadyHaveAnAccount,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const TextSpan(
                                    text: whiteSpace,
                                  ),
                                  TextSpan(
                                    text: signInInstead,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: baseColor,
                                        ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = supervisorSignUpState
                                              is! SigningUpSupervisorState
                                          ? () => Navigator.of(context)
                                                  .pushReplacementNamed(
                                                signInScreenRoute,
                                              )
                                          : null,
                                  ),
                                ],
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
            ),
          ),
        ),
      );
}
