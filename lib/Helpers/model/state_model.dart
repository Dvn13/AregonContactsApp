import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'state_model.g.dart';

@JsonSerializable()
class StateModel extends INetworkModel<StateModel> {
  int? basari;
  int? durum;
  String? mesaj;

  StateModel({this.basari, this.durum, this.mesaj});

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return _$StateModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
   
    return _$StateModelToJson(this);
  }

  @override
  StateModel fromJson(Map<String, dynamic> json) {
   return _$StateModelFromJson(json);
  }
}
