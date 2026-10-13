import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/app_env.dart';
import '../../auth/application/auth_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('설정')),
      body: ListView(
        children: [
          const ListTile(title: Text('계정')),
          ListTile(
            title: const Text('로그아웃'),
            onTap: () => ref.read(authControllerProvider.notifier).signOut(),
          ),
          if (!AppEnv.isProd) ListTile(title: const Text('서버'), subtitle: Text(AppEnv.apiBaseUrl)),
        ],
      ),
    );
  }
}
