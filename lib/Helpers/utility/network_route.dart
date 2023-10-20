import 'package:contacts_app/Helpers/exception/network_route_exception.dart';

enum NetworkRoute { baseUrl, login, contacts, city ,contact,town,addContact,delete}

extension NetworkRouteExtension on NetworkRoute {
  String get rawValue {
    switch (this) {
      case NetworkRoute.baseUrl:
        return 'http://www.motosikletci.com/api';
      case NetworkRoute.login:
        return '/oturum-test';
      case NetworkRoute.contacts:
        return '/kisiler';
      case NetworkRoute.contact:
        return '/kisi-goster';
       case NetworkRoute.addContact:
        return '/kisi-kaydet';
       case NetworkRoute.delete:
        return '/kisi-sil';
      case NetworkRoute.city:
        return '/iller';
      case NetworkRoute.town:
        return '/ilceler';
      default:
        throw NetworkRouteException();
    }
  }
}
