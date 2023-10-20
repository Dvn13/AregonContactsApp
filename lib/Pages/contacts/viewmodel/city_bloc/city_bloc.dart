import 'package:contacts_app/Pages/contacts/model/city_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/IContactsService.dart';
import 'city_events.dart';
import 'city_states.dart';

class CitysListBloc extends Bloc<CityListEvent, CityState> {
  final IContactsService contactsService;
  late List<Iller> dataItems;
  CitysListBloc(this.contactsService) : super(CityInitial()) {
    on<GetCity>(getCitys);
  }

  // City
  String? cityName;
  int? cityId;

  void getCitys(GetCity event, Emitter<CityState> emit) async {
    emit(CityLoadingState(true));

    await fetchData();
    if (dataItems.isNotEmpty) {
      emit(CityListItemState(dataItems));
    } else {
      emit(CityItemsErrorState());
    }
  }

  Future<void> fetchData() async {
    final items = await contactsService.fetchCity();

    if (items != null) {
      dataItems = items;
    }
  }
}
