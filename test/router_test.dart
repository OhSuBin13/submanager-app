import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:submanager/app/app.dart';
import 'package:submanager/app/router.dart';
import 'package:submanager/app/routes.dart';
import 'package:submanager/features/auth/application/auth_controller.dart';

class _FakeAuthController extends AuthController {
  _FakeAuthController(this.initial);

  final AuthStatus initial;

  @override
  AuthStatus build() => initial;
}

Widget _app(AuthStatus status) => ProviderScope(
  overrides: [authControllerProvider.overrideWith(() => _FakeAuthController(status))],
  child: const SubManagerApp(),
);

void main() {
  group('redirectFor', () {
    test('로그인 상태 확인 중에는 스플래시로 보낸다', () {
      expect(redirectFor(AuthStatus.unknown, Routes.home), Routes.splash);
      expect(redirectFor(AuthStatus.unknown, Routes.splash), isNull);
    });

    test('비회원은 온보딩·로그인만 볼 수 있다', () {
      expect(redirectFor(AuthStatus.unauthenticated, Routes.home), Routes.onboarding);
      expect(
        redirectFor(AuthStatus.unauthenticated, Routes.subscriptionDetail(1)),
        Routes.onboarding,
      );
      expect(redirectFor(AuthStatus.unauthenticated, Routes.login), isNull);
    });

    test('회원이 로그인 화면에 오면 홈으로 보낸다', () {
      expect(redirectFor(AuthStatus.authenticated, Routes.login), Routes.home);
      expect(redirectFor(AuthStatus.authenticated, Routes.splash), Routes.home);
      expect(redirectFor(AuthStatus.authenticated, Routes.stats), isNull);
    });
  });

  testWidgets('비회원으로 시작하면 온보딩이 보이고 시작하기로 로그인 화면에 간다', (tester) async {
    await tester.pumpWidget(_app(AuthStatus.unauthenticated));
    await tester.pumpAndSettle();

    expect(find.text('시작하기'), findsOneWidget);

    await tester.tap(find.text('시작하기'));
    await tester.pumpAndSettle();
    expect(find.text('로그인'), findsOneWidget);
  });

  testWidgets('회원은 홈 탭에서 시작하고 하단 탭으로 이동한다', (tester) async {
    await tester.pumpWidget(_app(AuthStatus.authenticated));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);

    await tester.tap(find.text('통계'));
    await tester.pumpAndSettle();
    expect(find.text('지출 통계'), findsOneWidget);
  });
}
