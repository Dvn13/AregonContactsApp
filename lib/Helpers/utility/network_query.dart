import 'package:contacts_app/Pages/contacts/model/contacts_data.dart';

enum NetworkQuery { login, page, contact, townQery, deleteContact }

extension NetworkQeryExtension on NetworkQuery {
  Iterable<MapEntry<String, dynamic>> loginQueryParameters(
      String email, String password) {
    return [
      MapEntry('email', email),
      MapEntry('sifre', password),
    ];
  }

  Iterable<MapEntry<String, dynamic>> pageQuery(int pageNumber, String email,
      String password, String? kisiAd, int? cinsiyet, int? cityId) {
    return [
      MapEntry('email', email),
      MapEntry('sifre', password),
      MapEntry('page', pageNumber),
      MapEntry('kisi_ad', kisiAd),
      MapEntry('cinsiyet', cinsiyet),
      MapEntry('city_id', cityId),
    ];
  }

  Iterable<MapEntry<String, dynamic>> contact(
    String email,
    String password,
    int? kisiId,
  ) {
    return [
      MapEntry('email', email),
      MapEntry('sifre', password),
      MapEntry('kisi_id', kisiId),
    ];
  }

  Iterable<MapEntry<String, dynamic>> town(
    int cityId,
  ) {
    return [
      MapEntry('city_id', cityId),
    ];
  }

  Iterable<MapEntry<String, dynamic>> crudContact(
      Data data, String email, String sifre) {
    return [
      MapEntry('email', email),
      MapEntry('sifre', sifre),
      MapEntry('kisi_id', data.kisiId),
      MapEntry('city_id', data.cityId),
      MapEntry('town_id', data.townId),
      MapEntry('kisi_ad', data.kisiAd),
      MapEntry('kisi_tel', data.kisiTel),
    ];
  }
}
