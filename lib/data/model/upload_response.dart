import 'package:json_annotation/json_annotation.dart';
part 'upload_response.g.dart';

@JsonSerializable()
class UploadModel {
  final bool error;
  final String message;

  UploadModel({required this.error, required this.message});

  factory UploadModel.fromJson(Map<String, dynamic> json) =>
      _$UploadModelFromJson(json);
}
