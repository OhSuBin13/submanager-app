/// 화면 경로. 와이어프레임 화면과 1:1로 맞춘다.
abstract final class Routes {
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const pushPermission = '/push-permission';

  static const home = '/home';
  static const subscriptions = '/subscriptions';
  static const subscriptionNew = '/subscriptions/new';
  static String subscriptionDetail(int id) => '/subscriptions/$id';
  static const calendar = '/calendar';
  static const stats = '/stats';

  static const notifications = '/notifications';
  static const settings = '/settings';

  /// 로그인하지 않아도 볼 수 있는 화면
  static const public = {onboarding, login};
}
