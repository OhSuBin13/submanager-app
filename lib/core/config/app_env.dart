/// 실행 환경 값. `--dart-define-from-file=env/dev.json`(또는 prod.json)으로 주입한다.
class AppEnv {
  const AppEnv._();

  static const String name = String.fromEnvironment('APP_ENV', defaultValue: 'dev');

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8080',
  );

  static bool get isProd => name == 'prod';
}
