import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/widgets/screen_placeholder.dart';

/// 로그인 직후 푸시 권한 안내. 실제 권한 요청(firebase_messaging)은 COD-10에서 붙인다.
class PushPermissionScreen extends StatelessWidget {
  const PushPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenPlaceholder(
        title: '결제일 3일 전에 알려드릴게요',
        actions: [
          FilledButton(onPressed: () => context.go(Routes.home), child: const Text('알림 받기')),
          TextButton(onPressed: () => context.go(Routes.home), child: const Text('나중에')),
        ],
      ),
    );
  }
}
