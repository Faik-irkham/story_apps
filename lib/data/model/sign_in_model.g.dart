// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInModel _$SignInModelFromJson(Map<String, dynamic> json) => SignInModel(
      error: json['error'] as bool,
      message: json['message'] as String,
      loginResult:
          LoginResult.fromJson(json['loginResult'] as Map<String, dynamic>),
    );

LoginResult _$LoginResultFromJson(Map<String, dynamic> json) => LoginResult(
      userId: json['userId'] as String,
      name: json['name'] as String,
      token: json['token'] as String,
    );
