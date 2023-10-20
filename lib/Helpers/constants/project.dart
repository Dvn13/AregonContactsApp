import 'package:vexana/vexana.dart';

import '../utility/network_route.dart';

class ProjectConstants {
  static ProjectConstants? _instace;
  static ProjectConstants get instance {
    _instace ??= ProjectConstants._init();
    return _instace!;
  }

  // ignore: prefer_void_to_null
  INetworkManager networkManager = NetworkManager<Null>(
    isEnableLogger: true,
    options: BaseOptions(baseUrl: NetworkRoute.baseUrl.rawValue),
  );

  ProjectConstants._init();
}
