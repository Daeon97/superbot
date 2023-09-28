// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superbot/cubits/chats_cubit/chats_cubit.dart';
import 'package:superbot/cubits/send_message_cubit/send_message_cubit.dart';
import 'package:superbot/cubits/sign_out_cubit/sign_out_cubit.dart';
import 'package:superbot/resources/colors.dart';
import 'package:superbot/resources/numbers.dart';
import 'package:superbot/resources/strings/routes.dart';
import 'package:superbot/resources/strings/ui.dart';
import 'package:superbot/utils/enums.dart' as enums;
import 'package:superbot/utils/helpers/time_util.dart';

class StudentChatScreen extends StatefulWidget {
  const StudentChatScreen({super.key});

  @override
  State<StudentChatScreen> createState() => _StudentChatScreenState();
}

class _StudentChatScreenState extends State<StudentChatScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _messageFieldController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _messageFieldController = TextEditingController();

    context.read<ChatsCubit>().listenChats();

    super.initState();
  }

  @override
  void deactivate() {
    context.read<ChatsCubit>().stopListeningChats();
    super.deactivate();
  }

  @override
  void dispose() {
    _messageFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<SignOutCubit, SignOutState>(
        listener: (_, signOutState) {
          if (signOutState is SignOutSuccessState) {
            Navigator.of(context).pushReplacementNamed(
              signInScreenRoute,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Supervisor name should be here',
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => context.read<SignOutCubit>().signOut(),
                icon: const Icon(
                  Icons.logout,
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<ChatsCubit, ChatsState>(
                    builder: (_, chatsState) => ListView.builder(
                      itemCount: chatsState.chats.length,
                      itemBuilder: (__, index) => Row(
                        children: [
                          switch (chatsState.chats[index].isReply) {
                            true => const SizedBox.shrink(),
                            false => const Expanded(
                                child: SizedBox.shrink(),
                              ),
                          },
                          Expanded(
                            flex: four,
                            child: Container(
                              margin: EdgeInsetsDirectional.only(
                                top: spacing,
                                start: spacing,
                                end: spacing,
                                bottom: index == chatsState.chats.length - one
                                    ? spacing
                                    : nil,
                              ),
                              padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: spacing,
                                vertical: smallSpacing,
                              ),
                              decoration: BoxDecoration(
                                color: switch (
                                    chatsState.chats[index].isReply) {
                                  true => chatReplyColor,
                                  false => baseColor,
                                },
                                borderRadius: BorderRadiusDirectional.only(
                                  topStart: const Radius.circular(
                                    chatBorderRadius,
                                  ),
                                  topEnd: const Radius.circular(
                                    chatBorderRadius,
                                  ),
                                  bottomStart: switch (
                                      chatsState.chats[index].isReply) {
                                    true => Radius.zero,
                                    false => const Radius.circular(
                                        chatBorderRadius,
                                      ),
                                  },
                                  bottomEnd: switch (
                                      chatsState.chats[index].isReply) {
                                    true => const Radius.circular(
                                        chatBorderRadius,
                                      ),
                                    false => Radius.zero,
                                  },
                                ),
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.topStart,
                                    child: Text(
                                      chatsState.chats[index].message,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: switch (chatsState
                                                .chats[index].isReply) {
                                              true => null,
                                              false => Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                            },
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: tinySpacing,
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        switch (
                                            chatsState.chats[index].isReply) {
                                          true => const SizedBox.shrink(),
                                          false => Icon(
                                              switch (chatsState.chats[index]
                                                  .deliveryStatus) {
                                                enums.MessageDeliveryStatus
                                                      .sending =>
                                                  Icons.access_time,
                                                enums.MessageDeliveryStatus
                                                      .failed =>
                                                  Icons.error,
                                                enums.MessageDeliveryStatus
                                                      .sent =>
                                                  Icons.done_all,
                                              },
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              size: spacing + tinySpacing,
                                            ),
                                        },
                                        const SizedBox(
                                          width: tinySpacing + tinySpacing,
                                        ),
                                        Text(
                                          TimeUtil.computeDayMonthYear(
                                            chatsState.chats[index].sentAt,
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: switch (chatsState
                                                    .chats[index].isReply) {
                                                  true => null,
                                                  false => Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                },
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          switch (chatsState.chats[index].isReply) {
                            true => const Expanded(
                                child: SizedBox.shrink(),
                              ),
                            false => const SizedBox.shrink(),
                          },
                        ],
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.all(
                      spacing,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child:
                              BlocBuilder<SendMessageCubit, SendMessageState>(
                            builder: (_, sendMessageState) => TextFormField(
                              controller: _messageFieldController,
                              keyboardType: TextInputType.text,
                              enabled: sendMessageState is! SendingMessageState,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: askMeAnything,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: spacing,
                        ),
                        BlocBuilder<SendMessageCubit, SendMessageState>(
                          builder: (_, sendMessageState) => ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                baseColor,
                              ),
                              shape: MaterialStatePropertyAll<OutlinedBorder>(
                                CircleBorder(),
                              ),
                              padding:
                                  MaterialStatePropertyAll<EdgeInsetsGeometry>(
                                EdgeInsetsDirectional.symmetric(
                                  vertical: spacing,
                                ),
                              ),
                            ),
                            onPressed: sendMessageState is! SendingMessageState
                                ? () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      if (_messageFieldController
                                          .text.isNotEmpty) {
                                        context
                                            .read<SendMessageCubit>()
                                            .sendMessage(
                                              _messageFieldController.text,
                                            );
                                      }
                                    }
                                  }
                                : null,
                            child: Icon(
                              Icons.send,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
