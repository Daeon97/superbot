// ignore_for_file: public_member_api_docs

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
  late final ValueNotifier<String?> _statusNotifier;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _statusNotifier = ValueNotifier<String?>(
      null,
    );
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _statusNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: WillPopScope(
            onWillPop: () async {
              await Navigator.of(context).pushReplacementNamed(
                signInScreenRoute,
              ); // probably do some manip here based on dynamic links
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
                        TextFormField(
                          controller: _nameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.done,
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
                                  statusFirstDropdownItemIndex => supervisor,
                                  _ => coSupervisor,
                                },
                                child: Text(
                                  switch (index) {
                                    statusFirstDropdownItemIndex => supervisor,
                                    _ => coSupervisor,
                                  },
                                ),
                              ),
                            ),
                            onChanged: (value) => _statusNotifier.value = value,
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
                              signUp,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(
                              width: largeSpacing,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.of(context)
                                          .pushReplacementNamed(
                                        signInScreenRoute,
                                      ), // probably do some manip here based on dynamic links
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
            ),
          ),
        ),
      );
}
