// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_form_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpFormModel _$SignUpFormModelFromJson(Map<String, dynamic> json) =>
    SignUpFormModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$SignUpFormModelToJson(SignUpFormModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
    };
