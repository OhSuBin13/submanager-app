import 'package:flutter/material.dart';

import '../../../core/widgets/screen_placeholder.dart';

/// 와이어프레임의 "구독 추가 1/2(서비스 선택)·2/2(금액·결제일)" 화면
class SubscriptionAddScreen extends StatelessWidget {
  const SubscriptionAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('구독 추가')),
      body: const ScreenPlaceholder(title: '서비스 선택'),
    );
  }
}
