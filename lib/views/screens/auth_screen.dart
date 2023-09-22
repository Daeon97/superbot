// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:superbot/resources/numbers.dart';
import 'package:superbot/resources/strings/ui.dart';
import 'package:superbot/views/widgets/sign_in_page.dart';
import 'package:superbot/views/widgets/sign_up_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SignInPage(
                pageController: _pageController,
              ),
              SignUpPage(
                pageController: _pageController,
              ),
            ],
          ),
        ),
      );
}
