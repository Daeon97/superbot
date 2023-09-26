// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:superbot/resources/numbers.dart';
import 'package:superbot/resources/strings/assets_paths.dart';

class LoadingRouteScreen extends StatelessWidget {
  const LoadingRouteScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Image.asset(
                loadingIllustrationPath,
              ),
            ),
          ),
        ),
      );
}
