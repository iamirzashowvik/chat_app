import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NetworkStatus { ONLINE, OFFLINE }

final _initNetworkStatusProvider = FutureProvider<NetworkStatus>((ref) async {
  NetworkStatus networkStatus;
  networkStatus = await Connectivity().checkConnectivity().then((result) =>
      result.contains(ConnectivityResult.wifi) ||
              result.contains(ConnectivityResult.mobile)
          ? NetworkStatus.ONLINE
          : NetworkStatus.OFFLINE);
  return networkStatus;
});

final networkStatusProvider = StreamProvider<NetworkStatus>((ref) {
  StreamController<NetworkStatus> controller =
      StreamController<NetworkStatus>();

  if (ref.watch(_initNetworkStatusProvider).value != null) {
    controller.sink.add(ref.watch(_initNetworkStatusProvider).value!);
  }

  Connectivity().onConnectivityChanged.listen((result) {
    controller.add(result.contains(ConnectivityResult.wifi) ||
            result.contains(ConnectivityResult.mobile)
        ? NetworkStatus.ONLINE
        : NetworkStatus.OFFLINE);
  });
  return controller.stream;
});
