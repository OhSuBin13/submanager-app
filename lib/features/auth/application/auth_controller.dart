import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/token_storage.dart';

enum AuthStatus { unknown, unauthenticated, authenticated }

final authControllerProvider = NotifierProvider<AuthController, AuthStatus>(AuthController.new);

/// 로그인 상태. 라우터가 이 값을 보고 로그인 화면과 메인 화면을 오간다.
/// 실제 소셜·이메일 로그인 API 호출은 COD-7에서 붙인다.
class AuthController extends Notifier<AuthStatus> {
  @override
  AuthStatus build() {
    _restore();
    return AuthStatus.unknown;
  }

  Future<void> _restore() async {
    final token = await ref.read(tokenStorageProvider).readAccessToken();
    state = token == null ? AuthStatus.unauthenticated : AuthStatus.authenticated;
  }

  Future<void> signIn({required String accessToken, required String refreshToken}) async {
    await ref.read(tokenStorageProvider).save(accessToken: accessToken, refreshToken: refreshToken);
    state = AuthStatus.authenticated;
  }

  Future<void> signOut() async {
    await ref.read(tokenStorageProvider).clear();
    state = AuthStatus.unauthenticated;
  }
}
