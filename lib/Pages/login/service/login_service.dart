import 'package:contacts_app/Helpers/utility/network_query.dart';
import 'package:contacts_app/Helpers/utility/network_route.dart';
import 'package:contacts_app/Pages/login/model/login_response_model.dart';
import 'package:contacts_app/Pages/login/service/ILoginService.dart';
import 'package:vexana/vexana.dart';

class LoginService extends ILoginService {
  LoginService({required super.networkManager});

  @override
  Future<LoginResponseModel?> fetchLoginResponse(
      String email, String password) async {
    final response =
        await networkManager.send<LoginResponseModel, LoginResponseModel>(
            NetworkRoute.login.rawValue,
            parseModel: LoginResponseModel(),
            method: RequestType.POST,
            queryParameters: Map.fromEntries(
                NetworkQuery.login.loginQueryParameters(email, password)));
    final loginResponseModel = response.data;
    if (loginResponseModel != null) {
      return loginResponseModel;
    } else {
      return null;
    }
  }
}
