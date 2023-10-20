import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Helpers/shared_pref.dart';
import '../../../../Helpers/sqlite.dart';
import '../../../login/model/login_user_model.dart';
import '../../model/city_model.dart';
import '../../model/contacts_data.dart';
import '../../service/IContactsService.dart';
import 'contacts_events.dart';
import 'contacts_states.dart';

class ContactsListBloc extends Bloc<ContactsListEvent, ContactsState> {
  final IContactsService contactsService;

  ContactsListBloc(this.contactsService) : super(ContactsInitial()) {
    on<DeleteContact>(_deleteContacts);
    on<GetContacts>(getContacts);
    on<PageChanged>(pageChanged);
  }
  //Page Number
  int _pageNumber = 1;
  // City
  int? cityId;
  String? cityName;
  // Gender
  int? genderId;
  String? genderName;
  // Name
  String? name;
  // Current Id
  int currentId = 0;
  // Login Model
  late LoginUserModel? userModel;
  // Kisiler
  late Kisiler? contacts;
  late List<Data> dataItems;
  // City
  late List<Iller> cityItems;
  // Loadings
  bool contactsLoading = false;

  Future<void> _deleteContacts(
      DeleteContact event, Emitter<ContactsState> emit) async {
    await deleteContact();
    await fetchContacts();
    if (contacts != null) {
      emit(ContactsListItemState(dataItems, contacts!));
    } else {
      emit(ContactsItemsErrorState());
    }
  }

  void getContacts(GetContacts event, Emitter<ContactsState> emit) async {
    emit(ContactsLoadingState(true));
    await getUser();
    await fetchContacts();
    if (contacts != null) {
      emit(ContactsListItemState(dataItems, contacts!));
    } else {
      emit(ContactsItemsErrorState());
    }
  }

  void pageChanged(PageChanged event, Emitter<ContactsState> emit) async {
    contactsLoading = true;
    await fetchContacts();
    if (contacts != null) {
      emit(ContactsListItemState(dataItems, contacts!));
    } else {
      emit(ContactsItemsErrorState());
    }
    contactsLoading = false;
  }

  Future<void> deleteContact() async {
    await contactsService.deleteContactData(
      email: userModel!.email ?? "",
      password: userModel!.sifre ?? "",
      kisiId: currentId,
    );
  }

  Future<void> fetchContacts() async {
    final items = await contactsService.fetchContactsData(
        page: _pageNumber,
        email: userModel!.email ?? "",
        password: userModel!.sifre ?? "",
        cityId: cityId,
        cinsiyet: genderId,
        kisiAd: name);

    if (items != null) {
      dataItems = items.data ?? [];
      contacts = items;
    }
  }

  int? parsePage(String dataUrl) {
    final url = dataUrl;

    final uri = Uri.parse(url);

    final pageParam = uri.queryParameters['page'];

    if (pageParam != null) {
      final page = int.tryParse(pageParam);
      if (page != null) {
        return page;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  void setPageNumber(int pageNmbr) {
    _pageNumber = pageNmbr;
  }

  Future<LoginUserModel?> getUser() async {
    SqLiteHelper sqHelper = SqLiteHelper.instance;
    SharedPreferencesManager prefsManager =
        await SharedPreferencesManager.getInstance();
    String email = await prefsManager.getEmail();
    userModel = await sqHelper.getUser(email);
    return userModel;
  }
}
