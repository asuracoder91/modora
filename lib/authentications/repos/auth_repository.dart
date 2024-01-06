import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:uuid/uuid.dart';

import '../../core/constants/firebase_constants.dart';
import 'handle_exception.dart';

class AuthRepository {
  User? get currentUser => fbAuth.currentUser;

  Future<void> signup({
    required String nickname,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await fbAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final signedInUser = userCredential.user!;

      await usersCollection.doc(signedInUser.uid).set({
        'nickname': nickname,
        'email': email,
      });
    } catch (e) {
      throw handleException(e);
    }
  }

  /// email 중복 체크
  Future<bool> isEmailRegistered(String email) async {
    final querySnapshot = await usersCollection
        .where('email', isEqualTo: email)
        .limit(1)

        /// 1개 발견시 바로 종료
        .get();

    /// 쿼리 결과가 비어있지 않다면(즉, 일치하는 문서가 있다면) true를 반환
    return querySnapshot.docs.isNotEmpty;
  }

  /// Login with Email and Password
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await fbAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw handleException(e);
    }
  }

  /// Sign In with Google
  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    print("sign in with google step 1");
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return null;
    }
    print("sign in with google step 2");

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    print("sign in with google step 3");
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("sign in with google step 4");
    UserCredential authResult = await fbAuth.signInWithCredential(credential);

    return authResult;
  }

  /// TODO: Sign In with Apple 미구현 상태 (수정할 것)
  Future<UserCredential?> signInWithApple() async {
    try {
      bool isAvailable = await SignInWithApple.isAvailable();
      if (isAvailable) {
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
            clientId: "bookBuddy.asuracoder.com",
            redirectUri: Uri.parse(
              'https://beryl-spotty-ironclad.glitch.me/callbacks/sign_in_with_apple',
            ),
          ),
        );

        final oauthCredential = OAuthProvider("apple.com").credential(
          idToken: appleCredential.identityToken,
          accessToken: appleCredential.authorizationCode,
        );

        return await fbAuth.signInWithCredential(oauthCredential);
      } else {
        final clientState = const Uuid().v4();

        final url = Uri.https('appleid.apple.com', '/auth/authorize', {
          'response_type': 'code id_token',
          'client_id': "bookBuddy.asuracoder.com",
          'response_mode': 'form_post',
          'redirect_uri':
              'https://beryl-spotty-ironclad.glitch.me/callbacks/apple/sign_in',
          'scope': 'email name',
          'state': clientState,
        });

        final result = await FlutterWebAuth.authenticate(
          url: url.toString(),
          callbackUrlScheme: "applink",
        );

        final body = Uri.parse(result).queryParameters;

        final oauthCredentialWeb = OAuthProvider("apple.com").credential(
          idToken: body['id_token'],
          accessToken: body['code'],
        );

        return await fbAuth.signInWithCredential(oauthCredentialWeb);
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  /// Sign Out
  Future<void> signout() async {
    try {
      await fbAuth.signOut();
    } catch (e) {
      throw handleException(e);
    }
  }

  /// Change Password
  Future<void> changePassword(String password) async {
    try {
      await currentUser!.updatePassword(password);
    } catch (e) {
      throw handleException(e);
    }
  }

  /// Reset Password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await fbAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw handleException(e);
    }
  }

  /// Verify Email
  Future<void> sendEmailVerification() async {
    try {
      await currentUser!.sendEmailVerification();
    } catch (e) {
      throw handleException(e);
    }
  }

  /// Reload User Credential
  Future<void> reloadUser() async {
    try {
      await currentUser!.reload();
    } catch (e) {
      throw handleException(e);
    }
  }

  /// Reauthenticate
  Future<void> reauthenticateWithCredential(
    String email,
    String password,
  ) async {
    try {
      await currentUser!.reauthenticateWithCredential(
        EmailAuthProvider.credential(email: email, password: password),
      );
    } catch (e) {
      throw handleException(e);
    }
  }
}
