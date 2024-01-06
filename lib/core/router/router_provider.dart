import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:modora/authentications/views/firebase_error_screen.dart';
import 'package:modora/authentications/views/login_screen.dart';
import 'package:modora/authentications/views/signup_screen.dart';
import 'package:modora/authentications/views/splash_screen.dart';
import 'package:modora/features/view/calendar_screen.dart';
import 'package:modora/features/view/history_screen.dart';
import 'package:modora/features/view/posts_screen.dart';
import 'package:modora/features/view/write_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../authentications/repos/auth_repository_provider.dart';
import '../../features/view/home_screen.dart';
import '../../features/view/listpage_screen.dart';
import '../../features/view/settings_screen.dart';
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
      return (authenticating || splashing) ? '/history' : null;
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
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/history',
                name: RouteNames.history,
                builder: (context, state) {
                  return const History();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/listpage',
                name: RouteNames.listpage,
                builder: (context, state) {
                  return const ListPage();
                },
                routes: [
                  GoRoute(
                    path: 'posts/:id',
                    name: RouteNames.posts,
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;

                      return PostsPage(
                        id: id,
                      );
                    },
                  ),
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'write',
                    name: RouteNames.write,
                    builder: (context, state) {
                      return const WritePage();
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/calendar',
                name: RouteNames.calendar,
                builder: (context, state) {
                  return const Calendar();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                name: RouteNames.settings,
                builder: (context, state) {
                  return const Settings();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

final selectedIndexProvider = StateProvider<int>((ref) => 0);
