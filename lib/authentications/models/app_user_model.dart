import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'app_user_model.freezed.dart';

@freezed
class AppUserModel with _$AppUserModel {
  const factory AppUserModel({
    @Default('') String id,
    @Default('') String nickname,
    @Default('') String email,
    @Default(false) bool premium,
    DateTime? expirationDate,
    @Default(0) int postCount,
  }) = _AppUserModel;

  factory AppUserModel.fromDoc(DocumentSnapshot appUserDoc) {
    final appUserModelData = appUserDoc.data() as Map<String, dynamic>;
    return AppUserModel(
      id: appUserDoc.id,
      nickname: appUserModelData['nickname'],
      email: appUserModelData['email'],
      premium: appUserModelData['premium'],
      expirationDate: appUserModelData['expirationDate']?.toDate(),
      postCount: appUserModelData['postCount'],
    );
  }
}
