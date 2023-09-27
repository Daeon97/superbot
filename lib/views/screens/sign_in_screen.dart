// ignore_for_file: public_member_api_docs

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superbot/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:superbot/resources/colors.dart';
import 'package:superbot/resources/numbers.dart';
import 'package:superbot/resources/strings/characters.dart';
import 'package:superbot/resources/strings/routes.dart';
import 'package:superbot/resources/strings/ui.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
  Widget build(BuildContext context) => BlocListener<SignInCubit, SignInState>(
        listener: (_, signInState) {
          if (signInState is SignInFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  signInState.failure.reason,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                ),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          } else if (signInState is SignInSuccessState) {
            Navigator.of(context).pushReplacementNamed(
              signInState.route,
            );
          }
        },
        child: Scaffold(
          body: SafeArea(
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
                            welcome,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        const SizedBox(
                          height: largeSpacing,
                        ),
                        BlocBuilder<SignInCubit, SignInState>(
                          builder: (_, signInState) => TextFormField(
                            controller: _emailController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            enabled: signInState is! SigningInState,
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
                        BlocBuilder<SignInCubit, SignInState>(
                          builder: (_, signInState) =>
                              ValueListenableBuilder<bool>(
                            valueListenable: _obscurePasswordNotifier,
                            builder: (_, obscurePassword, __) => TextFormField(
                              controller: _passwordController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              obscureText: obscurePassword,
                              enabled: signInState is! SigningInState,
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
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: largeSpacing,
                        ),
                        BlocBuilder<SignInCubit, SignInState>(
                          builder: (_, signInState) => ElevatedButton(
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
                            onPressed: signInState is! SigningInState
                                ? () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      context.read<SignInCubit>().signIn(
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                          );
                                    }
                                  }
                                : null,
                            child: Center(
                              child: signInState is! SigningInState
                                  ? Text(
                                      signIn,
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
                        BlocBuilder<SignInCubit, SignInState>(
                          builder: (_, signInState) => RichText(
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
                                  text: signUpInstead,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: baseColor,
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = signInState is! SigningInState
                                        ? () => Navigator.of(context)
                                                .pushReplacementNamed(
                                              supervisorSignUpScreenRoute,
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
      );
}
