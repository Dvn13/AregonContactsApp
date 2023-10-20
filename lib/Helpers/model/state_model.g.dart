// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateModel _$StateModelFromJson(Map<String, dynamic> json) => StateModel(
      basari: json['basari'] as int?,
      durum: json['durum'] as int?,
      mesaj: json['mesaj'] as String?,
    );

Map<String, dynamic> _$StateModelToJson(StateModel instance) =>
    <String, dynamic>{
      'basari': instance.basari,
      'durum': instance.durum,
      'mesaj': instance.mesaj,
    };
