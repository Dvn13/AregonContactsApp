// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactsDetail _$ContactsDetailFromJson(Map<String, dynamic> json) =>
    ContactsDetail(
      kisi: json['kisi'] == null
          ? null
          : Data.fromJson(json['kisi'] as Map<String, dynamic>),
      basari: json['basari'] as int?,
      durum: json['durum'] as int?,
    );

Map<String, dynamic> _$ContactsDetailToJson(ContactsDetail instance) =>
    <String, dynamic>{
      'kisi': instance.kisi,
      'basari': instance.basari,
      'durum': instance.durum,
    };
