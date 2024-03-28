import 'package:story_apps/data/model/login_result_model.dart';

class SignInModel {
  bool error;
  String message;
  LoginResult loginResult;

  SignInModel({
    required this.error,
    required this.message,
    required this.loginResult,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      error: json["error"],
      message: json["message"],
      loginResult: json["loginResult"] != null
          ? LoginResult.fromJson(json["loginResult"])
          : LoginResult(userId: '', name: '', token: ''),
    );
  }
}
