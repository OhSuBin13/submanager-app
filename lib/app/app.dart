import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router.dart';

class SubManagerApp extends ConsumerWidget {
  const SubManagerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: '구독관리',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: const Color(0xFF3B5BDB), useMaterial3: true),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
