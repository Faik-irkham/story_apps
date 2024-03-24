class RegisterModel {
  bool error;
  String message;

  RegisterModel({
    required this.error,
    required this.message,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        error: json["error"],
        message: json["message"],
      );
}
