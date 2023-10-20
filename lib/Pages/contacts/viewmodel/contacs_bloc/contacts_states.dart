import '../../model/contacts_data.dart';

abstract class ContactsState {}

class ContactsInitial extends ContactsState {}

class ContactsLoadingState extends ContactsState {
  final bool isLoading;

  ContactsLoadingState(this.isLoading);
}

class PageLoadingState extends ContactsState {
  final bool isLoading;

  PageLoadingState(this.isLoading);
}

class ContactsListItemState extends ContactsState {
  final List<Data> items;
  final Kisiler contacts;

  ContactsListItemState(this.items, this.contacts);
}

class ContactsItemsErrorState extends ContactsState {
  ContactsItemsErrorState();
}
