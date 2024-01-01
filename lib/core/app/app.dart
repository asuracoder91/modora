import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modora/core/core.dart';

import '../router/router_provider.dart';

class Modora extends ConsumerWidget {
  const Modora({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Modora',
      debugShowCheckedModeBanner: false,
      theme: ModoraTheme.light,
      routerConfig: router,
    );
  }
}
