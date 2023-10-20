import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'town_model.g.dart';

@JsonSerializable()
class TownModel extends INetworkModel<TownModel>{
  int? basari;
  int? durum;
  List<Ilceler>? ilceler;

  TownModel({this.basari, this.durum, this.ilceler});

  factory TownModel.fromJson(Map<String, dynamic> json) {
    return _$TownModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$TownModelToJson(this);
  }
  
  @override
  TownModel fromJson(Map<String, dynamic> json) {
   return _$TownModelFromJson(json);
  }
}

@JsonSerializable()
class Ilceler  extends INetworkModel<Ilceler> {
  int? townId;
  int? cityId;
  String? townName;

  Ilceler({this.townId, this.cityId, this.townName});

  factory Ilceler.fromJson(Map<String, dynamic> json) {
    return _$IlcelerFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$IlcelerToJson(this);
  }
  
  @override
  Ilceler fromJson(Map<String, dynamic> json) {
     return _$IlcelerFromJson(json);
  }
}
