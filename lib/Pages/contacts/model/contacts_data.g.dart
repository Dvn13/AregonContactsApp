// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactsData _$ContactsDataFromJson(Map<String, dynamic> json) => ContactsData(
      kisiler: json['kisiler'] == null
          ? null
          : Kisiler.fromJson(json['kisiler'] as Map<String, dynamic>),
      basari: json['basari'] as int?,
      durum: json['durum'] as int?,
    );

Map<String, dynamic> _$ContactsDataToJson(ContactsData instance) =>
    <String, dynamic>{
      'kisiler': instance.kisiler,
      'basari': instance.basari,
      'durum': instance.durum,
    };

Kisiler _$KisilerFromJson(Map<String, dynamic> json) => Kisiler(
      currentPage: json['current_page'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstPageUrl: json['first_page_url'] as String?,
      from: json['from'] as int?,
      lastPage: json['last_page'] as int?,
      lastPageUrl: json['last_page_url'] as String?,
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => Links.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextPageUrl: json['next_page_url'] as String?,
      path: json['path'] as String?,
      perPage: json['per_page'] as int?,
      prevPageUrl: json['prev_page_url'] as String?,
      to: json['to'] as int?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$KisilerToJson(Kisiler instance) => <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
      'first_page_url': instance.firstPageUrl,
      'from': instance.from,
      'last_page': instance.lastPage,
      'last_page_url': instance.lastPageUrl,
      'links': instance.links,
      'next_page_url': instance.nextPageUrl,
      'path': instance.path,
      'per_page': instance.perPage,
      'prev_page_url': instance.prevPageUrl,
      'to': instance.to,
      'total': instance.total,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      kisiId: json['kisi_id'] as int?,
      kisiAd: json['kisi_ad'] as String?,
      kisiTel: json["kisi_tel"] as String?,
      resim: json['resim'] as String?,
      cinsiyet: json['cinsiyet'] as int?,
      cityId: json['city_id'] as int?,
      townId: json['town_id'] as int?,
      cityName: json['city_name'] as String?,
      townName: json['town_name'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'kisi_id': instance.kisiId,
      'kisi_ad': instance.kisiAd,
      "kisi_tel": instance.kisiTel,
      'resim': instance.resim,
      'cinsiyet': instance.cinsiyet,
      'city_id': instance.cityId,
      'town_id': instance.townId,
      'city_name': instance.cityName,
      'town_name': instance.townName,
    };

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      url: json['url'] as String?,
      label: json['label'] as String?,
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'url': instance.url,
      'label': instance.label,
      'active': instance.active,
    };
