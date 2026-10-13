import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

/// 하단 탭 4개(홈·구독·캘린더·통계)와 상단의 알림·설정 버튼
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _titles = ['홈', '구독', '캘린더', '통계'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[navigationShell.currentIndex]),
        actions: [
          IconButton(
            tooltip: '알림',
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push(Routes.notifications),
          ),
          IconButton(
            tooltip: '설정',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(Routes.settings),
          ),
        ],
      ),
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) =>
            navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: '홈'),
          NavigationDestination(icon: Icon(Icons.list_alt_outlined), label: '구독'),
          NavigationDestination(icon: Icon(Icons.calendar_month_outlined), label: '캘린더'),
          NavigationDestination(icon: Icon(Icons.pie_chart_outline), label: '통계'),
        ],
      ),
    );
  }
}
