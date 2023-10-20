import 'package:contacts_app/Helpers/model/state_model.dart';
import 'package:contacts_app/Pages/contacts/model/city_model.dart';
import 'package:contacts_app/Pages/contacts/model/town_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vexana/vexana.dart';

import '../model/contacts_data.dart';

abstract class IContactsService {
  final INetworkManager networkManager;

  IContactsService({required this.networkManager});

  Future<Kisiler?> fetchContactsData(
      {int page = 0,
      String email = "",
      String password = "",
      String? kisiAd,
      int? cinsiyet,
      int? cityId});

  Future<Data?> fetchContactData(
      {
      String email = "",
      String password = "",
      int kisiId,
      });
  Future<StateModel?> deleteContactData(
      {
      String email = "",
      String password = "",
      int kisiId,
      });

  Future<List<Iller>?> fetchCity();

  Future<List<Ilceler>?> fetchTown({int cityId=0});
  Future<StateModel?> addOrUpDateContact(Data data, XFile? file,String email,String sifre);
 
}
