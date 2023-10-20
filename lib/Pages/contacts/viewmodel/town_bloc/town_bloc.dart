import 'package:contacts_app/Pages/contacts/model/town_model.dart';
import 'package:contacts_app/Pages/contacts/service/IContactsService.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/town_bloc/town_events.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/town_bloc/town_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TownsListBloc extends Bloc<TownListEvent, TownState> {
  final IContactsService contactsService;
  late List<Ilceler> dataItems;
  TownsListBloc(this.contactsService) : super(TownInitial()) {
    on<GetTown>(getTowns);
  }

  String? townName;

  int? townId;
  int? cityId;

  void getTowns(GetTown event, Emitter<TownState> emit) async {
    emit(TownLoadingState(true));

    await fetchData();
    if (dataItems.isNotEmpty) {
      emit(TownListItemState(dataItems));
    }
  }

  Future<void> fetchData() async {
    final items = await contactsService.fetchTown(cityId: cityId!);

    if (items != null) {
      dataItems = items;
    }
  }
}
