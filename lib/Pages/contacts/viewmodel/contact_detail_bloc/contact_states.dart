import '../../model/contacts_data.dart';

abstract class ContactState {}

class ContactInitial extends ContactState {}

class ContactLoadingState extends ContactState {
  final bool isLoading;

  ContactLoadingState(this.isLoading);
}

class PageLoadingState extends ContactState {
  final bool isLoading;

  PageLoadingState(this.isLoading);
}

class ContactItemState extends ContactState {
  final Data data;

  ContactItemState(this.data);
}

class ContactItemsErrorState extends ContactState {
  ContactItemsErrorState();
}
