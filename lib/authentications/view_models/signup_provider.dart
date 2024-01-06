import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repos/auth_repository_provider.dart';
import '../repos/handle_exception.dart';

part 'signup_provider.g.dart';

@riverpod
class Signup extends _$Signup {
  /// state 에러 방지를 위한 오브젝트 키
  Object? _key;

  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() {
      _key = null;
    });
  }

  Future<void> signup({
    required String nickname,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading<void>();
    final key = _key;

    final newState = await AsyncValue.guard<void>(
      () => ref
          .read(authRepositoryProvider)
          .signup(nickname: nickname, email: email, password: password),
    );

    if (key == _key) {
      state = newState;
    }

    if (state.hasError) {
      if (state.error is FirebaseAuthException) {
        FirebaseAuthException firebaseError =
            state.error as FirebaseAuthException;
        String msg = mapFirebaseErrorMessages(firebaseError.code);

        ref.read(signUpErrorMessageProvider.notifier).state = msg;
      } else {
        ref.container.read(signUpErrorMessageProvider.notifier).state =
            "알 수 없는 오류가 발생했습니다.";
      }
    }
  }
}

final signUpErrorMessageProvider = StateProvider<String?>((ref) => null);

final formDataProvider =
    StateProvider.autoDispose<Map<String, String>>((ref) => {});
