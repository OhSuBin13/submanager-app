import 'package:flutter/material.dart';

import '../../../core/widgets/screen_placeholder.dart';

/// 카카오·네이버·Google·이메일 로그인. 각 SDK 연동은 COD-7에서 붙인다.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ScreenPlaceholder(title: '로그인'));
  }
}
