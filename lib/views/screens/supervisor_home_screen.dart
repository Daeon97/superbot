// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superbot/cubits/copy_link_cubit/copy_link_cubit.dart';
import 'package:superbot/resources/colors.dart';
import 'package:superbot/resources/numbers.dart';
import 'package:superbot/resources/strings/ui.dart';

class SupervisorHomeScreen extends StatefulWidget {
  const SupervisorHomeScreen({super.key});

  @override
  State<SupervisorHomeScreen> createState() => _SupervisorHomeScreenState();
}

class _SupervisorHomeScreenState extends State<SupervisorHomeScreen> {
  @override
  Widget build(BuildContext context) =>
      BlocListener<CopyLinkCubit, CopyLinkState>(
        listener: (_, copyLinkState) {
          if (copyLinkState is CopyLinkSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  copiedToClipboard,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                ),
                backgroundColor: baseColor,
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              students,
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  // ignore: inference_failure_on_function_invocation
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: spacing,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: spacing,
                          ),
                          const Icon(
                            Icons.link,
                            color: baseColor,
                            size: largeSpacing + spacing,
                          ),
                          Text(
                            shareLink,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          const SizedBox(
                            height: smallSpacing,
                          ),
                          Text(
                            copyYourLink,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            height: spacing,
                          ),
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
                            onPressed: () => context
                                .read<CopyLinkCubit>()
                                .copyInviteLinkToClipboard(),
                            child: Center(
                              child: Text(
                                copyLink,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: spacing,
                          ),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                Theme.of(context).scaffoldBackgroundColor,
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
                            onPressed: () => Navigator.of(context).pop(),
                            child: Center(
                              child: Text(
                                cancel,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: spacing,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.link,
                  color: baseColor,
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Placeholder(),
            // child: ListView.builder(itemBuilder: itemBuilder),
          ),
        ),
      );
}
