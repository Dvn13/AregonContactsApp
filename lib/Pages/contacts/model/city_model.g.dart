// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityModel _$CityModelFromJson(Map<String, dynamic> json) => CityModel(
      iller: (json['iller'] as List<dynamic>?)
          ?.map((e) => Iller.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as int?,
    );

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
      'iller': instance.iller,
      'success': instance.success,
    };

Iller _$IllerFromJson(Map<String, dynamic> json) => Iller(
      cityId: json['city_id'] as int?,
      cityName: json['city_name'] as String?,
    );

Map<String, dynamic> _$IllerToJson(Iller instance) => <String, dynamic>{
      'city_id': instance.cityId,
      'city_name': instance.cityName,
    };
