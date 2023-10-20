import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'city_model.g.dart';

@JsonSerializable()
class CityModel extends INetworkModel<CityModel> {
  List<Iller>? iller;
  int? success;

  CityModel({this.iller, this.success});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return _$CityModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$CityModelToJson(this);
  }

  @override
  CityModel fromJson(Map<String, dynamic> json) {
    return _$CityModelFromJson(json);
  }
}

@JsonSerializable()
class Iller extends INetworkModel<Iller> {
  int? cityId;
  String? cityName;

  Iller({this.cityId, this.cityName});

  factory Iller.fromJson(Map<String, dynamic> json) {
    return _$IllerFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$IllerToJson(this);
  }

  @override
  Iller fromJson(Map<String, dynamic> json) {
    return _$IllerFromJson(json);
  }
}
