// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superbot/cubits/chats_cubit/chats_cubit.dart';
import 'package:superbot/resources/colors.dart';
import 'package:superbot/resources/numbers.dart';
import 'package:superbot/utils/enums.dart' as enums;
import 'package:superbot/utils/helpers/time_util.dart';

class SupervisorChatScreen extends StatefulWidget {
  const SupervisorChatScreen({
    required this.uid,
    required this.name,
    super.key,
  });

  final String uid;
  final String name;

  @override
  State<SupervisorChatScreen> createState() => _SupervisorChatScreenState();
}

class _SupervisorChatScreenState extends State<SupervisorChatScreen> {
  late final ScrollController _chatsListViewScrollController;
  late final ValueNotifier<bool> _scrollNotifier;

  @override
  void initState() {
    context.read<ChatsCubit>().listenChats(
          uid: widget.uid,
        );

    _scrollNotifier = ValueNotifier<bool>(
      true,
    );
    _chatsListViewScrollController = ScrollController(
      onAttach: (scrollPosition) async {
        await Future<void>.delayed(
          const Duration(
            milliseconds: waitTimeBeforeScrollingToEndOfChat,
          ),
        );
        await _animateToEnd();
        _scrollNotifier.value = false;
      },
    );

    super.initState();
  }

  @override
  void deactivate() {
    context.read<ChatsCubit>().stopListeningChats();
    super.deactivate();
  }

  @override
  void dispose() {
    _scrollNotifier.dispose();
    _chatsListViewScrollController.dispose();
    super.dispose();
  }

  Future<void> _animateToEnd() => _chatsListViewScrollController.animateTo(
    _chatsListViewScrollController.position.maxScrollExtent,
    duration: const Duration(
      milliseconds: chatsListViewScrollAnimationDuration,
    ),
    curve: Curves.easeIn,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            widget.name,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: BlocBuilder<ChatsCubit, ChatsState>(
            builder: (_, chatsState) => ListView.builder(
              controller: _chatsListViewScrollController,
              itemCount: chatsState.chats.length,
              itemBuilder: (__, index) => Row(
                children: [
                  switch (chatsState.chats[index].isReply) {
                    false => const SizedBox.shrink(),
                    true => const Expanded(
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
                        color: switch (chatsState.chats[index].isReply) {
                          false => chatReplyColor,
                          true => baseColor,
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
                            false => Radius.zero,
                            true => const Radius.circular(
                                chatBorderRadius,
                              ),
                          },
                          bottomEnd: switch (chatsState.chats[index].isReply) {
                            false => const Radius.circular(
                                chatBorderRadius,
                              ),
                            true => Radius.zero,
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
                                    color: switch (
                                        chatsState.chats[index].isReply) {
                                      false => null,
                                      true => Theme.of(context)
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
                                switch (chatsState.chats[index].isReply) {
                                  false => const SizedBox.shrink(),
                                  true => Icon(
                                      switch (chatsState
                                          .chats[index].deliveryStatus) {
                                        enums.MessageDeliveryStatus.sending =>
                                          Icons.access_time,
                                        enums.MessageDeliveryStatus.failed =>
                                          Icons.error,
                                        enums.MessageDeliveryStatus.sent =>
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
                                        color: switch (
                                            chatsState.chats[index].isReply) {
                                          false => null,
                                          true => Theme.of(context)
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
                    false => const Expanded(
                        child: SizedBox.shrink(),
                      ),
                    true => const SizedBox.shrink(),
                  },
                ],
              ),
            ),
          ),
        ),
      );
}
