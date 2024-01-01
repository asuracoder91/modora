import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modora/authentications/views/firebase_error_screen.dart';
import 'package:modora/authentications/views/login_screen.dart';
import 'package:modora/authentications/views/signup_screen.dart';
import 'package:modora/authentications/views/splash_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'router_names.dart';

part 'router_provider.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/signup',
    routes: [
      GoRoute(
        path: '/splash',
        name: RouteNames.splash,
        builder: (context, state) {
          print('##### Splash #####');
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: '/firebaseError',
        name: RouteNames.firebaseError,
        builder: (context, state) {
          return const FirebaseErrorScreen();
        },
      ),
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/signup',
        name: RouteNames.signup,
        builder: (context, state) {
          return const SignUpScreen();
        },
      ),
    ],
  );
}
