import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'contacts_data.g.dart';

@JsonSerializable()
class ContactsData extends INetworkModel<ContactsData> {
  Kisiler? kisiler;
  int? basari;
  int? durum;

  ContactsData({this.kisiler, this.basari, this.durum});

  factory ContactsData.fromJson(Map<String, dynamic> json) {
    return _$ContactsDataFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ContactsDataToJson(this);
  }

  @override
  ContactsData fromJson(Map<String, dynamic> json) {
    return _$ContactsDataFromJson(json);
  }
}

@JsonSerializable()
class Kisiler extends INetworkModel<Kisiler> {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Kisiler(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  factory Kisiler.fromJson(Map<String, dynamic> json) {
    return _$KisilerFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$KisilerToJson(this);
  }

  @override
  Kisiler fromJson(Map<String, dynamic> json) {
    return _$KisilerFromJson(json);
  }

  void add(Data data) {}
}

@JsonSerializable()
class Data extends INetworkModel<Data> {
  int? kisiId;
  String? kisiAd;
  String? kisiTel;
  String? resim;
  int? cinsiyet;
  int? cityId;
  int? townId;
  String? cityName;
  String? townName;

  Data(
      {this.kisiId,
      this.kisiAd,
      this.kisiTel,
      this.resim,
      this.cinsiyet,
      this.cityId,
      this.townId,
      this.cityName,
      this.townName});

  factory Data.fromJson(Map<String, dynamic> json) {
    return _$DataFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$DataToJson(this);
  }

  @override
  Data fromJson(Map<String, dynamic> json) {
    return _$DataFromJson(json);
  }
}

@JsonSerializable()
class Links extends INetworkModel<Links> {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  factory Links.fromJson(Map<String, dynamic> json) {
    return _$LinksFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$LinksToJson(this);
  }

  @override
  Links fromJson(Map<String, dynamic> json) {
    return _$LinksFromJson(json);
  }
}
