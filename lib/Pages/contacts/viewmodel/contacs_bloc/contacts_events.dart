

abstract class ContactsListEvent {}


class GetInitinial extends ContactsListEvent {
  
  GetInitinial();
}


class GetContacts extends ContactsListEvent {
  GetContacts();
}




class PageChanged extends ContactsListEvent {
  PageChanged();
}


class DeleteContact extends ContactsListEvent {
  
  DeleteContact();
}

class UpdateContact extends ContactsListEvent {
  UpdateContact();
}



