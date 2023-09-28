// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superbot/cubits/chats_cubit/chats_cubit.dart';
import 'package:superbot/resources/colors.dart';
import 'package:superbot/resources/numbers.dart';
import 'package:superbot/resources/strings/ui.dart';

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

    // context.read<ChatsCubit>().listenChats();

    super.initState();
  }

  @override
  void deactivate() {
    // context.read<ChatsCubit>().stopListeningChats();
    super.deactivate();
  }

  @override
  void dispose() {
    _messageFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Supervisor name should be here',
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      color: baseColor,
                      height: 40,
                      child: Column(
                        children: [
                          Text('Hello! there',),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.grey,
                      height: 40,
                      child: Column(
                        children: [
                          Text('Hello there! How may I assist you today?',),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded(
              //   child: ListView.builder(
              //     itemBuilder: itemBuilder,
              //   ),
              // ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(
                    spacing,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _messageFieldController,
                          keyboardType: TextInputType.text,
                          // enabled:
                          // studentSignUpState is! SigningUpStudentState,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: askMeAnything,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: spacing,
                      ),
                      ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                            baseColor,
                          ),
                          shape: MaterialStatePropertyAll<OutlinedBorder>(
                            CircleBorder(),
                          ),
                          padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                            EdgeInsetsDirectional.symmetric(
                              vertical: spacing,
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            if (_messageFieldController.text.isNotEmpty) {
                              //.
                            }
                          }
                        },
                        child: Icon(
                          Icons.send,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
