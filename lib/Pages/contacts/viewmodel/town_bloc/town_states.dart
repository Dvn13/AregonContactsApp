import 'package:contacts_app/Pages/contacts/model/town_model.dart';

abstract class TownState {}

class TownInitial extends TownState {}

class TownLoadingState extends TownState {
  final bool isLoading;

  TownLoadingState(this.isLoading);
}

class TownListItemState extends TownState {
  final List<Ilceler> items;

  TownListItemState(this.items);
}

class TownItemsErrorState extends TownState {
  TownItemsErrorState();
}