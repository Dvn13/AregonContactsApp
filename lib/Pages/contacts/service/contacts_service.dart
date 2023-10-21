import 'package:contacts_app/Helpers/constants/application.dart';
import 'package:contacts_app/Helpers/model/state_model.dart';
import 'package:contacts_app/Helpers/toast.dart';
import 'package:contacts_app/Pages/contacts/model/city_model.dart';
import 'package:contacts_app/Pages/contacts/model/contacts_data.dart';
import 'package:contacts_app/Pages/contacts/model/contacts_detail.dart';
import 'package:contacts_app/Pages/contacts/model/town_model.dart';
import 'package:contacts_app/Pages/contacts/service/IContactsService.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vexana/vexana.dart';
import '../../../Helpers/utility/network_query.dart';
import '../../../Helpers/utility/network_route.dart';

class ContactsService extends IContactsService {
  ContactsService(INetworkManager manager) : super(networkManager: manager);

  @override
  Future<Kisiler?> fetchContactsData(
      {int page = 0,
      String email = "",
      String password = "",
      String? kisiAd,
      int? cinsiyet,
      int? cityId}) async {
    final response = await networkManager.send<ContactsData, ContactsData>(
      NetworkRoute.contacts.rawValue,
      parseModel: ContactsData(),
      method: RequestType.POST,
      queryParameters: Map.fromEntries(NetworkQuery.page
          .pageQuery(page, email, password, kisiAd, cinsiyet, cityId)),
    );

    final contactsModel = response.data;
    if (contactsModel != null) {
      final contacts = contactsModel.kisiler;
      if (contacts != null) {
        return contacts;
      }
    } else {
      Toastr.show(response.error!.description.toString(), 5);
    }

    return null;
  }

  @override
  Future<Data?> fetchContactData(
      {String email = "", String password = "", int kisiId = 0}) async {
    final response = await networkManager.send<ContactsDetail, ContactsDetail>(
      NetworkRoute.contact.rawValue,
      parseModel: ContactsDetail(),
      method: RequestType.POST,
      queryParameters: Map.fromEntries(
          NetworkQuery.contact.contact(email, password, kisiId)),
    );

    final contactModel = response.data;
    if (contactModel != null) {
      final contacts = contactModel.kisi;
      if (contacts != null) {
        return contacts;
      }
    } else {
      Toastr.show(response.error!.description.toString(), 5);
    }

    return null;
  }

  @override
  Future<List<Iller>?> fetchCity() async {
    try {
      final response = await networkManager.send<CityModel, CityModel>(
        NetworkRoute.city.rawValue,
        parseModel: CityModel(),
        method: RequestType.GET,
      );

      final data = response.data;

      if (data != null) {
        final city = data.iller;
        final success = data.success;

        if (success == 1) {
          return city;
        } else {
          Toastr.show(response.error!.description.toString(), 5);
          return null;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching city data: $e");
      }
    }

    return null;
  }

  @override
  Future<List<Ilceler>?> fetchTown({int cityId = 0}) async {
    final response = await networkManager.send<TownModel, TownModel>(
      NetworkRoute.town.rawValue,
      parseModel: TownModel(),
      method: RequestType.POST,
      queryParameters: Map.fromEntries(NetworkQuery.townQery.town(cityId)),
    );

    final data = response.data;

    if (data != null) {
      final city = data.ilceler;
      final success = data.basari;

      if (success == 1) {
        return city;
      } else {
        Toastr.show(response.error!.description.toString(), 5);
        return null;
      }
    }

    return null;
  }

  @override
  Future<StateModel?> addOrUpDateContact(
      Data data, XFile? file, String email, String sifre) async {
    FormData formData = FormData();
    StateModel stateModel = StateModel();
    String fileName = "";
    formData.fields.add(MapEntry("kisi_id", data.kisiId.toString()));
    formData.fields.add(MapEntry("city_id", data.cityId.toString()));
    formData.fields.add(MapEntry("town_id", data.townId.toString()));
    formData.fields.add(MapEntry("kisi_ad", data.kisiAd.toString()));
    formData.fields.add(MapEntry("kisi_tel", data.kisiTel.toString()));
    formData.fields.add(MapEntry("cinsiyet", data.cinsiyet.toString()));
    formData.fields.add(MapEntry("email", email));

    formData.fields.add(MapEntry("sifre", sifre));

    try {
      if (file != null) {
        fileName = file.path.split('/').last;
        formData.files.add(MapEntry(
          "resim",
          await MultipartFile.fromFile(file.path, filename: fileName),
        ));
      } else {
        String path = "";
        if (data.resim == null) {
          path = ApplicationConstats.DEFAULT_IMAGE_URL + data.kisiAd.toString();
          fileName = "default.jpg";
        } else {
          path = ApplicationConstats.CONTACTS_IMAGE_BASE_URL + data.resim!;
          fileName = data.resim!;
        }

        final response =
            await networkManager.downloadFileSimple(path, (count, total) {
          if (kDebugMode) {
            print('$count');
          }
        });
        List<int> fileBytes = response.data!;
        MultipartFile file = MultipartFile.fromBytes(
          fileBytes,
          filename: fileName,
        );

        formData.files.add(MapEntry("resim", file));
      }
    } on DioException catch (e) {
      Toastr.show(e.toString(), 5);
    }

    var response = await networkManager.uploadFile(
        NetworkRoute.addContact.rawValue, formData);
    stateModel = StateModel.fromJson(response.data);

    Toastr.show(stateModel.mesaj!, stateModel.durum!);
    return stateModel;
  }

  @override
  Future<StateModel?> deleteContactData(
      {String email = "", String password = "", int kisiId = 0}) async {
    final response = await networkManager.send<StateModel, StateModel>(
      NetworkRoute.delete.rawValue,
      parseModel: StateModel(),
      method: RequestType.POST,
      queryParameters: Map.fromEntries(
          NetworkQuery.deleteContact.contact(email, password, kisiId)),
    );

    final stateModel = response.data;
    if (stateModel != null) {
      Toastr.show(stateModel.mesaj!, stateModel.durum!);
      return stateModel;
    } else {
      Toastr.show(response.error!.description.toString(), 5);
    }

    return null;
  }
}
