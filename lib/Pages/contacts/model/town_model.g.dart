// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'town_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TownModel _$TownModelFromJson(Map<String, dynamic> json) => TownModel(
      basari: json['basari'] as int?,
      durum: json['durum'] as int?,
      ilceler: (json['ilceler'] as List<dynamic>?)
          ?.map((e) => Ilceler.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TownModelToJson(TownModel instance) => <String, dynamic>{
      'basari': instance.basari,
      'durum': instance.durum,
      'ilceler': instance.ilceler,
    };

Ilceler _$IlcelerFromJson(Map<String, dynamic> json) => Ilceler(
      townId: json['town_id'] as int?,
      cityId: json['city_id'] as int?,
      townName: json['town_name'] as String?,
    );

Map<String, dynamic> _$IlcelerToJson(Ilceler instance) => <String, dynamic>{
      'town_id': instance.townId,
      'city_id': instance.cityId,
      'town_name': instance.townName,
    };
