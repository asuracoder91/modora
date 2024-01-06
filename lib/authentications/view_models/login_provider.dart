import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repos/auth_repository_provider.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {
  @override
  FutureOr<void> build() {}

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading<void>();

    state = await AsyncValue.guard<void>(
      () => ref
          .read(authRepositoryProvider)
          .login(email: email, password: password),
    );
  }
}

final loginErrorMessageProvider = StateProvider<String?>((ref) => null);
