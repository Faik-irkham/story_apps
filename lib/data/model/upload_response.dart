class UploadModel {
  final bool error;
  final String message;

  UploadModel({required this.error, required this.message});

  factory UploadModel.fromJson(Map<String, dynamic> json) {
    return UploadModel(
      error: json['error'],
      message: json['message'],
    );
  }
}
