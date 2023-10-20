import 'package:contacts_app/Helpers/model/state_model.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/contact_detail_bloc/contact_event.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/contact_detail_bloc/contact_states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../login/model/login_user_model.dart';
import '../../model/contacts_data.dart';
import '../../service/IContactsService.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final IContactsService contactService;

  ContactBloc(this.contactService) : super(ContactInitial()) {
    on<GetContact>(getContact);
    on<AddOrUpdateContact>(_addOrUpdateContacts);
    on<DataUpdate>(update);
    on<Add>(defaultContact);
  }

  // Login Model
  late LoginUserModel? userModel;
  // Contact
  late Data? data;
  // Current Id
  int currentId = 0;

  // Image Network Control
  bool isNetwork = true;

  // Picker Image
  XFile? photo;

  void getContact(GetContact event, Emitter<ContactState> emit) async {
    emit(ContactLoadingState(true));

    await fetchContact();
    if (data != null) {
      emit(ContactItemState(data!));
    } else {
      emit(ContactItemsErrorState());
    }
  }

  void _addOrUpdateContacts(
      AddOrUpdateContact event, Emitter<ContactState> emit) async {
    await addOrUpdateContact();
    if (data != null) {
      emit(ContactItemState(data!));
    } else {
      emit(ContactItemsErrorState());
    }
  }

  void update(DataUpdate event, Emitter<ContactState> emit) async {
    if (data != null) {
      emit(ContactItemState(data!));
    } else {
      emit(ContactItemsErrorState());
    }
  }

  void defaultContact(Add event, Emitter<ContactState> emit) async {
    Data emptyData = Data(kisiId: 0);
    data = emptyData;
    emit(ContactItemState(data!));
  }

  Future<Data> fetchContact() async {
    final items = await contactService.fetchContactData(
        email: userModel!.email ?? "",
        password: userModel!.sifre ?? "",
        kisiId: currentId);

    if (items != null) {
      return data = items;
    }

    return Data();
  }

  Future<StateModel> addOrUpdateContact() async {
    final state = await contactService.addOrUpDateContact(
        data!, photo, userModel!.email!, userModel!.sifre!);

    if (state != null) {
      return state;
    }
    photo = null;
    return StateModel();
  }

  Future<void> imagePicker() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photoFile = await picker.pickImage(source: ImageSource.camera);
    try {
      if (photoFile != null) {
        // print(photo.readAsBytes());

        photo = photoFile;
        isNetwork = false;
      } else {
        if (kDebugMode) {
          print('No Image Selected');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
