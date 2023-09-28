// ignore_for_file: public_member_api_docs

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superbot/cubits/student_sign_up_cubit/student_sign_up_cubit.dart';
import 'package:superbot/cubits/verify_link_cubit/verify_link_cubit.dart';
import 'package:superbot/resources/colors.dart';
import 'package:superbot/resources/numbers.dart';
import 'package:superbot/resources/strings/characters.dart';
import 'package:superbot/resources/strings/routes.dart';
import 'package:superbot/resources/strings/ui.dart';

class StudentSignUpScreen extends StatefulWidget {
  const StudentSignUpScreen({super.key});

  @override
  State<StudentSignUpScreen> createState() => _StudentSignUpScreenState();
}

class _StudentSignUpScreenState extends State<StudentSignUpScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final ValueNotifier<String?> _degreeTypeNotifier;
  late final ValueNotifier<String?> _courseOfStudyNotifier;
  late final TextEditingController _regNoController;
  late final TextEditingController _supervisorInviteLinkController;
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
    _courseOfStudyNotifier = ValueNotifier<String?>(
      null,
    );
    _regNoController = TextEditingController();
    _supervisorInviteLinkController = TextEditingController();
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
    _courseOfStudyNotifier.dispose();
    _regNoController.dispose();
    _supervisorInviteLinkController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _obscurePasswordNotifier.dispose();
    _obscureConfirmPasswordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiBlocListener(
        listeners: [
          BlocListener<VerifyLinkCubit, VerifyLinkState>(
            listener: (_, verifyLinkState) {
              if (verifyLinkState is VerifyLinkFailureState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      verifyLinkState.failure.reason,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                );
              } else if (verifyLinkState is VerifyLinkSuccessState) {
                context.read<StudentSignUpCubit>().signUpStudent(
                      name: _nameController.text,
                      email: _emailController.text,
                      degreeType: _degreeTypeNotifier.value!,
                      courseOfStudy: _courseOfStudyNotifier.value!,
                      regNo: _regNoController.text,
                      supervisorUid: verifyLinkState.supervisorUid,
                      password: _passwordController.text,
                    );
              }
            },
          ),
          BlocListener<StudentSignUpCubit, StudentSignUpState>(
            listener: (_, studentSignUpState) {
              if (studentSignUpState is StudentSignUpFailureState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      studentSignUpState.failure.reason,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                );
              } else if (studentSignUpState is StudentSignUpSuccessState) {
                Navigator.of(context).pushReplacementNamed(
                  studentChatScreenRoute,
                );
              }
            },
          ),
        ],
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
                          BlocBuilder<VerifyLinkCubit, VerifyLinkState>(
                            builder: (_, verifyLinkState) => BlocBuilder<
                                StudentSignUpCubit, StudentSignUpState>(
                              builder: (_, studentSignUpState) => TextFormField(
                                controller: _nameController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                enabled:
                                    verifyLinkState is! VerifyingLinkState ||
                                        studentSignUpState
                                            is! SigningUpStudentState,
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
                          ),
                          const SizedBox(
                            height: largeSpacing,
                          ),
                          BlocBuilder<VerifyLinkCubit, VerifyLinkState>(
                            builder: (_, verifyLinkState) => BlocBuilder<
                                StudentSignUpCubit, StudentSignUpState>(
                              builder: (_, studentSignUpState) => TextFormField(
                                controller: _emailController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done,
                                enabled:
                                    verifyLinkState is! VerifyingLinkState ||
                                        studentSignUpState
                                            is! SigningUpStudentState,
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
                          ),
                          const SizedBox(
                            height: largeSpacing,
                          ),
                          BlocBuilder<VerifyLinkCubit, VerifyLinkState>(
                            builder: (_, verifyLinkState) => BlocBuilder<
                                StudentSignUpCubit, StudentSignUpState>(
                              builder: (_, studentSignUpState) =>
                                  ValueListenableBuilder<String?>(
                                valueListenable: _degreeTypeNotifier,
                                builder: (_, degreeTypeNotifierValue, __) =>
                                    DropdownButtonFormField<String>(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  value: degreeTypeNotifierValue,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: degreeType,
                                    prefixIcon: Icon(
                                      Icons.school,
                                    ),
                                  ),
                                  items:
                                      List<DropdownMenuItem<String>>.generate(
                                    degreeTypeDropdownOptionsLength,
                                    (index) => DropdownMenuItem<String>(
                                      value: switch (index) {
                                        degreeTypeFirstDropdownItemIndex =>
                                          undergraduate,
                                        _ => postgraduate,
                                      },
                                      child: Text(
                                        switch (index) {
                                          degreeTypeFirstDropdownItemIndex =>
                                            undergraduate,
                                          _ => postgraduate,
                                        },
                                      ),
                                    ),
                                  ),
                                  onChanged:
                                      verifyLinkState is! VerifyingLinkState ||
                                              studentSignUpState
                                                  is! SigningUpStudentState
                                          ? (value) =>
                                              _degreeTypeNotifier.value = value
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
                          ),
                          const SizedBox(
                            height: largeSpacing,
                          ),
                          BlocBuilder<VerifyLinkCubit, VerifyLinkState>(
                            builder: (_, verifyLinkState) => BlocBuilder<
                                StudentSignUpCubit, StudentSignUpState>(
                              builder: (_, studentSignUpState) =>
                                  ValueListenableBuilder<String?>(
                                valueListenable: _courseOfStudyNotifier,
                                builder: (_, courseOfStudyNotifierValue, __) =>
                                    DropdownButtonFormField<String>(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  value: courseOfStudyNotifierValue,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: courseOfStudy,
                                    prefixIcon: Icon(
                                      Icons.book,
                                    ),
                                  ),
                                  items:
                                      List<DropdownMenuItem<String>>.generate(
                                    courseOfStudyDropdownOptionsLength,
                                    (index) => DropdownMenuItem<String>(
                                      value: switch (index) {
                                        courseOfStudyFirstDropdownItemIndex =>
                                          computerScience,
                                        courseOfStudySecondDropdownItemIndex =>
                                          massCommunication,
                                        _ => economics,
                                      },
                                      child: Text(
                                        switch (index) {
                                          courseOfStudyFirstDropdownItemIndex =>
                                            computerScience,
                                          courseOfStudySecondDropdownItemIndex =>
                                            massCommunication,
                                          _ => economics,
                                        },
                                      ),
                                    ),
                                  ),
                                  onChanged: verifyLinkState
                                              is! VerifyingLinkState ||
                                          studentSignUpState
                                              is! SigningUpStudentState
                                      ? (value) =>
                                          _courseOfStudyNotifier.value = value
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
                          ),
                          const SizedBox(
                            height: largeSpacing,
                          ),
                          BlocBuilder<VerifyLinkCubit, VerifyLinkState>(
                            builder: (_, verifyLinkState) => BlocBuilder<
                                StudentSignUpCubit, StudentSignUpState>(
                              builder: (_, studentSignUpState) => TextFormField(
                                controller: _regNoController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                enabled:
                                    verifyLinkState is! VerifyingLinkState ||
                                        studentSignUpState
                                            is! SigningUpStudentState,
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
                            ),
                          ),
                          const SizedBox(
                            height: largeSpacing,
                          ),
                          BlocBuilder<VerifyLinkCubit, VerifyLinkState>(
                            builder: (_, verifyLinkState) => BlocBuilder<
                                StudentSignUpCubit, StudentSignUpState>(
                              builder: (_, studentSignUpState) => TextFormField(
                                controller: _supervisorInviteLinkController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                enabled:
                                    verifyLinkState is! VerifyingLinkState ||
                                        studentSignUpState
                                            is! SigningUpStudentState,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: supervisorInviteLink,
                                  prefixIcon: Icon(
                                    Icons.link,
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
                          ),
                          const SizedBox(
                            height: largeSpacing,
                          ),
                          BlocBuilder<VerifyLinkCubit, VerifyLinkState>(
                            builder: (_, verifyLinkState) => BlocBuilder<
                                StudentSignUpCubit, StudentSignUpState>(
                              builder: (_, studentSignUpState) =>
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
                                  enabled:
                                      verifyLinkState is! VerifyingLinkState ||
                                          studentSignUpState
                                              is! SigningUpStudentState,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: password,
                                    prefixIcon: const Icon(
                                      Icons.password,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () =>
                                          switch (obscurePassword) {
                                        true => _obscurePasswordNotifier.value =
                                            false,
                                        false =>
                                          _obscurePasswordNotifier.value = true,
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
                          ),
                          const SizedBox(
                            height: largeSpacing,
                          ),
                          BlocBuilder<VerifyLinkCubit, VerifyLinkState>(
                            builder: (_, verifyLinkState) => BlocBuilder<
                                StudentSignUpCubit, StudentSignUpState>(
                              builder: (_, studentSignUpState) =>
                                  ValueListenableBuilder<bool>(
                                valueListenable:
                                    _obscureConfirmPasswordNotifier,
                                builder: (_, obscureConfirmPassword, __) =>
                                    TextFormField(
                                  controller: _confirmPasswordController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  obscureText: obscureConfirmPassword,
                                  enabled:
                                      verifyLinkState is! VerifyingLinkState ||
                                          studentSignUpState
                                              is! SigningUpStudentState,
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
                          ),
                          const SizedBox(
                            height: largeSpacing,
                          ),
                          BlocBuilder<VerifyLinkCubit, VerifyLinkState>(
                            builder: (_, verifyLinkState) => BlocBuilder<
                                StudentSignUpCubit, StudentSignUpState>(
                              builder: (_, studentSignUpState) =>
                                  ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      const MaterialStatePropertyAll<Color>(
                                    baseColor,
                                  ),
                                  shape:
                                      MaterialStatePropertyAll<OutlinedBorder>(
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
                                onPressed: verifyLinkState
                                            is! VerifyingLinkState ||
                                        studentSignUpState
                                            is! SigningUpStudentState
                                    ? () {
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          context
                                              .read<VerifyLinkCubit>()
                                              .verifyLink(
                                                _supervisorInviteLinkController
                                                    .text,
                                              );
                                        }
                                      }
                                    : null,
                                child: Center(
                                  child:
                                      verifyLinkState is! VerifyingLinkState ||
                                              studentSignUpState
                                                  is! SigningUpStudentState
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
                          ),
                          const SizedBox(
                            height: largeSpacing,
                          ),
                          BlocBuilder<VerifyLinkCubit, VerifyLinkState>(
                            builder: (_, verifyLinkState) => BlocBuilder<
                                StudentSignUpCubit, StudentSignUpState>(
                              builder: (_, studentSignUpState) => RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: alreadyHaveAnAccount,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
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
                                        ..onTap = verifyLinkState
                                                    is! VerifyingLinkState ||
                                                studentSignUpState
                                                    is! SigningUpStudentState
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
