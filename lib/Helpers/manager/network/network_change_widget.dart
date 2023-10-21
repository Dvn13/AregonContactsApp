import 'package:contacts_app/Helpers/constants/color.dart';
import 'package:contacts_app/Helpers/constants/text.dart';
import 'package:contacts_app/Helpers/manager/network/network_change_manager.dart';
import 'package:flutter/material.dart';

class NetworkWidget extends StatefulWidget {
  const NetworkWidget({super.key});

  @override
  State<NetworkWidget> createState() => _NetworkWidgetState();
}

class _NetworkWidgetState extends State<NetworkWidget> with StateMixin {
  late final INetworkChangeManager _networkChange;
  NetworkResult? _networkResult;
  @override
  void initState() {
    super.initState();
    _networkChange = NetworkChangeManager();

    waitForScreen(() {
      _networkChange.handleNetworkChange((result) {
        _updateView(result);
      });
    });
  }

  Future<void> fetchFirstResult() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final result = await _networkChange.checkNetworkFirstTime();
      _updateView(result);
    });
  }

  void _updateView(NetworkResult result) {
    setState(() {
      _networkResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 500),
      crossFadeState: _networkResult == NetworkResult.off
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      firstChild: Container(
          height: 50,
          color: ConstColor.red,
          child: Center(
            child: Text(
              ConstText.networkError,
              style: TextStyle(color: ConstColor.white),
            ),
          )),
      secondChild: const SizedBox(),
    );
  }
}

mixin StateMixin<T extends StatefulWidget> on State<T> {
  void waitForScreen(VoidCallback onComplete) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onComplete.call();
    });
  }
}
