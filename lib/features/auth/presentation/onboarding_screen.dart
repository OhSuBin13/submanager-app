import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/widgets/screen_placeholder.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenPlaceholder(
        title: '구독, 한 번 등록하면 결제일마다 알려드려요',
        actions: [
          FilledButton(onPressed: () => context.go(Routes.login), child: const Text('시작하기')),
        ],
      ),
    );
  }
}
