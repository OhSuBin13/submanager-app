import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/application/auth_controller.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/onboarding_screen.dart';
import '../features/calendar/presentation/calendar_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/notifications/presentation/notification_center_screen.dart';
import '../features/notifications/presentation/push_permission_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/stats/presentation/stats_screen.dart';
import '../features/subscriptions/presentation/subscription_add_screen.dart';
import '../features/subscriptions/presentation/subscription_detail_screen.dart';
import '../features/subscriptions/presentation/subscription_list_screen.dart';
import 'main_shell.dart';
import 'routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // 로그인 상태가 바뀌면 redirect를 다시 계산하도록 GoRouter에 알린다.
  final authStatus = ValueNotifier<AuthStatus>(ref.read(authControllerProvider));
  ref.listen(authControllerProvider, (_, next) => authStatus.value = next);
  ref.onDispose(authStatus.dispose);

  final router = GoRouter(
    initialLocation: Routes.home,
    refreshListenable: authStatus,
    redirect: (context, state) => redirectFor(authStatus.value, state.matchedLocation),
    routes: [
      GoRoute(path: Routes.splash, builder: (_, _) => const _SplashScreen()),
      GoRoute(path: Routes.onboarding, builder: (_, _) => const OnboardingScreen()),
      GoRoute(path: Routes.login, builder: (_, _) => const LoginScreen()),
      GoRoute(path: Routes.pushPermission, builder: (_, _) => const PushPermissionScreen()),
      StatefulShellRoute.indexedStack(
        builder: (_, _, navigationShell) => MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [GoRoute(path: Routes.home, builder: (_, _) => const HomeScreen())],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.subscriptions,
                builder: (_, _) => const SubscriptionListScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: Routes.calendar, builder: (_, _) => const CalendarScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: Routes.stats, builder: (_, _) => const StatsScreen())],
          ),
        ],
      ),
      // 탭 바 없이 전체 화면으로 여는 화면
      GoRoute(path: Routes.subscriptionNew, builder: (_, _) => const SubscriptionAddScreen()),
      GoRoute(
        path: '${Routes.subscriptions}/:id',
        builder: (_, state) =>
            SubscriptionDetailScreen(subscriptionId: int.parse(state.pathParameters['id']!)),
      ),
      GoRoute(path: Routes.notifications, builder: (_, _) => const NotificationCenterScreen()),
      GoRoute(path: Routes.settings, builder: (_, _) => const SettingsScreen()),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

/// 로그인 상태에 따라 갈 곳. null이면 요청한 화면 그대로 둔다.
@visibleForTesting
String? redirectFor(AuthStatus status, String location) {
  switch (status) {
    case AuthStatus.unknown:
      return location == Routes.splash ? null : Routes.splash;
    case AuthStatus.unauthenticated:
      return Routes.public.contains(location) ? null : Routes.onboarding;
    case AuthStatus.authenticated:
      final onAuthScreen = location == Routes.splash || Routes.public.contains(location);
      return onAuthScreen ? Routes.home : null;
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
