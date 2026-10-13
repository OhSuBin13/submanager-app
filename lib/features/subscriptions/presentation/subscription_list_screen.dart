import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/widgets/screen_placeholder.dart';

class SubscriptionListScreen extends StatelessWidget {
  const SubscriptionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenPlaceholder(
      title: '구독 목록',
      actions: [
        FilledButton(
          onPressed: () => context.push(Routes.subscriptionNew),
          child: const Text('구독 추가'),
        ),
      ],
    );
  }
}
