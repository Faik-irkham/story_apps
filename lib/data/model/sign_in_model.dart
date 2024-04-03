import 'package:json_annotation/json_annotation.dart';
part 'sign_in_model.g.dart';

@JsonSerializable()
class SignInModel {
  bool error;
  String message;
  LoginResult loginResult;

  SignInModel({
    required this.error,
    required this.message,
    required this.loginResult,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) =>
      _$SignInModelFromJson(json);
}

@JsonSerializable()
class LoginResult {
  String userId;
  String name;
  String token;

  LoginResult({
    required this.userId,
    required this.name,
    required this.token,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);
}
