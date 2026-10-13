import 'package:flutter/material.dart';

import '../../../core/widgets/screen_placeholder.dart';

class NotificationCenterScreen extends StatelessWidget {
  const NotificationCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('알림')),
      body: const ScreenPlaceholder(title: '알림 센터'),
    );
  }
}
