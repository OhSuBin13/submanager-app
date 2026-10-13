# submanager-app

구독관리 Android 앱입니다. Flutter 3.47 · Riverpod 3 · go_router.

## 실행

```bash
flutter pub get
flutter run --dart-define-from-file=env/dev.json     # 로컬 서버(에뮬레이터에서 http://10.0.2.2:8080)
flutter run --dart-define-from-file=env/prod.json    # 운영 서버
```

Android Studio·IntelliJ에서는 Run 설정의 **Additional run args**에 `--dart-define-from-file=env/dev.json`을 넣으면 됩니다.
실제 기기에서 로컬 서버에 붙을 때는 `env/dev.json`의 주소를 PC의 내부 IP로 바꾸세요.

```bash
flutter analyze
flutter test
dart format -l 100 lib test
```

## 환경 분리

| 파일 | APP_ENV | API_BASE_URL |
|---|---|---|
| `env/dev.json` | dev | `http://10.0.2.2:8080` (에뮬레이터 → PC의 localhost) |
| `env/prod.json` | prod | `https://api.<도메인>` (도메인 확정 후 교체) |

평문 HTTP는 디버그 빌드에서 `10.0.2.2`·`localhost`로만 허용합니다(`android/app/src/debug/res/xml/network_security_config.xml`).
패키지 이름은 Firebase·소셜 로그인에 등록한 `com.subin.submanager`입니다.

## 폴더 구성

```
lib/
├── app/            앱 루트, 라우터(로그인 상태에 따른 이동), 하단 탭
├── core/           환경값, API 클라이언트(dio), 토큰 저장소, 공통 위젯
└── features/
    ├── auth/           온보딩, 로그인, 로그인 상태
    ├── notifications/  푸시 권한 안내, 알림 센터
    ├── home/           홈
    ├── subscriptions/  구독 목록·상세·추가
    ├── calendar/       결제 캘린더
    ├── stats/          지출 통계
    └── settings/       설정, 계정
```

각 기능은 `presentation`(화면)부터 시작하고, 상태와 API 호출이 생기면 `application`·`data`를 추가합니다.
