import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modora/authentications/views/firebase_error_screen.dart';
import 'package:modora/authentications/views/login_screen.dart';
import 'package:modora/authentications/views/signup_screen.dart';
import 'package:modora/authentications/views/splash_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../authentications/repos/auth_repository_provider.dart';
import '../../features/view/home_screen.dart';
import '../constants/firebase_constants.dart';
import 'router_names.dart';

part 'router_provider.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(RouterRef ref) {
  final authState = ref.watch(authStateStreamProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    redirect: (context, state) {
      if (authState is AsyncLoading<User?>) {
        return '/splash';
      }

      if (authState is AsyncError<User?>) {
        return '/firebaseError';
      }

      final authenticated = authState.valueOrNull != null;

      final authenticating = (state.matchedLocation == '/login') ||
          (state.matchedLocation == '/signup') ||
          (state.matchedLocation == '/resetPassword');

      if (authenticated == false) {
        return authenticating ? null : '/login';
      }

      /// 나중에 이메일 인증이 필요하면 이 부분을 주석 해제
      // if (!fbAuth.currentUser!.emailVerified) {
      //   return '/verifyEmail';
      // }

      // final verifyingEmail = state.matchedLocation == '/verifyEmail';
      final splashing = state.matchedLocation == '/splash';

      // return (authenticating || verifyingEmail || splashing) ? '/home' : null;
      return (authenticating || splashing) ? '/home' : null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        name: RouteNames.splash,
        builder: (context, state) {
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
      GoRoute(
        path: '/home',
        name: RouteNames.home,
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
    ],
  );
}
