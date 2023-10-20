import 'package:contacts_app/Pages/contacts/model/contacts_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'contacts_detail.g.dart';

@JsonSerializable()
class ContactsDetail extends INetworkModel<ContactsDetail> {
  Data? kisi;
  int? basari;
  int? durum;

  ContactsDetail({this.kisi, this.basari, this.durum});

  factory ContactsDetail.fromJson(Map<String, dynamic> json) {
    return _$ContactsDetailFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ContactsDetailToJson(this);
  }

  @override
  ContactsDetail fromJson(Map<String, dynamic> json) {
    return _$ContactsDetailFromJson(json);
  }
}
