import 'package:firebase_auth/firebase_auth.dart';
import '../models/custom_error.dart';

CustomError handleException(e) {
  try {
    throw e;
  } on FirebaseAuthException catch (e) {
    return CustomError(
      code: e.code,
      message: e.message ?? 'Invalid credential',
      plugin: e.plugin,
    );
  } on FirebaseException catch (e) {
    return CustomError(
      code: e.code,
      message: e.message ?? 'Firebase Error',
      plugin: e.plugin,
    );
  } catch (e) {
    return CustomError(
      code: 'Exception',
      message: e.toString(),
      plugin: 'Unknow error',
    );
  }
}

String mapFirebaseErrorMessages(String errorCode) {
  switch (errorCode) {
    case "wrong-password":
      return "패스워드가 틀렸습니다";
    case "user-not-found":
      return "해당 이메일로 등록된 계정이 없습니다";
    case "too-many-requests":
      return "너무 많은 요청이 들어왔습니다. 잠시 후 다시 시도해주세요";
    case "email-already-in-use":
      return "이미 등록된 이메일입니다";
    case "invalid-email":
      return "이메일 형식이 올바르지 않습니다";
    case "weak-password":
      return "패스워드가 너무 짧거나 단순합니다";
    case "account-exists-with-different-credential":
      return "이미 등록된 이메일입니다";
    case "invalid-credential":
      return "이메일 형식이 올바르지 않습니다";
    case "operation-not-allowed":
      return "이메일 로그인이 허용되지 않았습니다";
    case "user-disabled":
      return "해당 계정은 비활성화되었습니다";
    case "user-mismatch":
      return "해당 이메일로 등록된 계정이 없습니다";
    default:
      return "알 수 없는 오류가 발생하였습니다";
  }
}
