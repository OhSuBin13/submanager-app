import 'package:flutter/material.dart';

/// 아직 구현하지 않은 화면의 자리 표시. 각 기능 이슈에서 실제 화면으로 바꾼다.
class ScreenPlaceholder extends StatelessWidget {
  const ScreenPlaceholder({super.key, required this.title, this.actions = const []});

  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          ...actions,
        ],
      ),
    );
  }
}
