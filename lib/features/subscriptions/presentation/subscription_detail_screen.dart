import 'package:flutter/material.dart';

import '../../../core/widgets/screen_placeholder.dart';

class SubscriptionDetailScreen extends StatelessWidget {
  const SubscriptionDetailScreen({super.key, required this.subscriptionId});

  final int subscriptionId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('구독 상세')),
      body: ScreenPlaceholder(title: '구독 #$subscriptionId'),
    );
  }
}
