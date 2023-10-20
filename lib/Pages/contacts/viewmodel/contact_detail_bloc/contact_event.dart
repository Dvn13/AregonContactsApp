abstract class ContactEvent {}

class GetInitinial extends ContactEvent {
  GetInitinial();
}

class GetContact extends ContactEvent {
  GetContact();
}

class DataUpdate extends ContactEvent {
  DataUpdate();
}

class AddOrUpdateContact extends ContactEvent {
  AddOrUpdateContact();
}


class Add extends ContactEvent {
  Add();
}
