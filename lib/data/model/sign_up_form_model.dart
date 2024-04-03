import 'package:json_annotation/json_annotation.dart';
part 'sign_up_form_model.g.dart';

@JsonSerializable()
class SignUpFormModel {
  final String? name;
  final String? email;
  final String? password;

  SignUpFormModel({
    this.name,
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() => _$SignUpFormModelToJson(this);
}
