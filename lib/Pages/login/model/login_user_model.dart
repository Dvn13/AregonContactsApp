import 'package:json_annotation/json_annotation.dart';

part 'login_user_model.g.dart';

@JsonSerializable()
class LoginUserModel {
  String? email;
  String? sifre;

  LoginUserModel({this.email, this.sifre});

 factory LoginUserModel.fromJson(Map<String, dynamic> json) {
    return _$LoginUserModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoginUserModelToJson(this);
  }
}
