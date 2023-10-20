// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      basari: json['basari'] as int?,
      durum: json['durum'] as int?,
      mesaj: json['mesaj'] as String?,
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'basari': instance.basari,
      'durum': instance.durum,
      'mesaj': instance.mesaj,
    };
