
import 'package:vexana/vexana.dart';

import '../model/login_response_model.dart';

abstract class ILoginService {
  final INetworkManager networkManager;

  ILoginService({required this.networkManager});

  Future<LoginResponseModel?> fetchLoginResponse(String email, String password);
}
