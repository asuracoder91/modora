// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppUserModel {
  String get id => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  bool get premium => throw _privateConstructorUsedError;
  DateTime? get expirationDate => throw _privateConstructorUsedError;
  int get postCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppUserModelCopyWith<AppUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserModelCopyWith<$Res> {
  factory $AppUserModelCopyWith(
          AppUserModel value, $Res Function(AppUserModel) then) =
      _$AppUserModelCopyWithImpl<$Res, AppUserModel>;
  @useResult
  $Res call(
      {String id,
      String nickname,
      String email,
      bool premium,
      DateTime? expirationDate,
      int postCount});
}

/// @nodoc
class _$AppUserModelCopyWithImpl<$Res, $Val extends AppUserModel>
    implements $AppUserModelCopyWith<$Res> {
  _$AppUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickname = null,
    Object? email = null,
    Object? premium = null,
    Object? expirationDate = freezed,
    Object? postCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      premium: null == premium
          ? _value.premium
          : premium // ignore: cast_nullable_to_non_nullable
              as bool,
      expirationDate: freezed == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      postCount: null == postCount
          ? _value.postCount
          : postCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppUserModelImplCopyWith<$Res>
    implements $AppUserModelCopyWith<$Res> {
  factory _$$AppUserModelImplCopyWith(
          _$AppUserModelImpl value, $Res Function(_$AppUserModelImpl) then) =
      __$$AppUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String nickname,
      String email,
      bool premium,
      DateTime? expirationDate,
      int postCount});
}

/// @nodoc
class __$$AppUserModelImplCopyWithImpl<$Res>
    extends _$AppUserModelCopyWithImpl<$Res, _$AppUserModelImpl>
    implements _$$AppUserModelImplCopyWith<$Res> {
  __$$AppUserModelImplCopyWithImpl(
      _$AppUserModelImpl _value, $Res Function(_$AppUserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickname = null,
    Object? email = null,
    Object? premium = null,
    Object? expirationDate = freezed,
    Object? postCount = null,
  }) {
    return _then(_$AppUserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      premium: null == premium
          ? _value.premium
          : premium // ignore: cast_nullable_to_non_nullable
              as bool,
      expirationDate: freezed == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      postCount: null == postCount
          ? _value.postCount
          : postCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AppUserModelImpl with DiagnosticableTreeMixin implements _AppUserModel {
  const _$AppUserModelImpl(
      {this.id = '',
      this.nickname = '',
      this.email = '',
      this.premium = false,
      this.expirationDate,
      this.postCount = 0});

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String nickname;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final bool premium;
  @override
  final DateTime? expirationDate;
  @override
  @JsonKey()
  final int postCount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppUserModel(id: $id, nickname: $nickname, email: $email, premium: $premium, expirationDate: $expirationDate, postCount: $postCount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppUserModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('nickname', nickname))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('premium', premium))
      ..add(DiagnosticsProperty('expirationDate', expirationDate))
      ..add(DiagnosticsProperty('postCount', postCount));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.premium, premium) || other.premium == premium) &&
            (identical(other.expirationDate, expirationDate) ||
                other.expirationDate == expirationDate) &&
            (identical(other.postCount, postCount) ||
                other.postCount == postCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, nickname, email, premium, expirationDate, postCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUserModelImplCopyWith<_$AppUserModelImpl> get copyWith =>
      __$$AppUserModelImplCopyWithImpl<_$AppUserModelImpl>(this, _$identity);
}

abstract class _AppUserModel implements AppUserModel {
  const factory _AppUserModel(
      {final String id,
      final String nickname,
      final String email,
      final bool premium,
      final DateTime? expirationDate,
      final int postCount}) = _$AppUserModelImpl;

  @override
  String get id;
  @override
  String get nickname;
  @override
  String get email;
  @override
  bool get premium;
  @override
  DateTime? get expirationDate;
  @override
  int get postCount;
  @override
  @JsonKey(ignore: true)
  _$$AppUserModelImplCopyWith<_$AppUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
