import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_env.dart';
import '../storage/token_storage.dart';

/// 서버 REST API 클라이언트. 저장된 액세스 토큰을 모든 요청에 붙인다.
/// 401일 때 리프레시 토큰으로 갱신하는 처리는 로그인 이슈(COD-7)에서 추가한다.
final dioProvider = Provider<Dio>((ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: AppEnv.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await tokenStorage.readAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    ),
  );
  return dio;
});
