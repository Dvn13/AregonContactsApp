
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel extends INetworkModel<LoginResponseModel> {
  int? basari;
  int? durum;
  String? mesaj;

  LoginResponseModel({this.basari, this.durum, this.mesaj});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$LoginResponseModelToJson(this);
  }
  
  @override
  LoginResponseModel fromJson(Map<String, dynamic> json) {
   return _$LoginResponseModelFromJson(json);
  }
}
