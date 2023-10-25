import 'dart:async';

import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:movietestapp/interface/controllers/watch_controller.dart';

class InternetController extends GetxController {
  Rx<bool> showRefresh = Rx(false);
  final watchViewController = Get.find<WatchViewController>();
  late StreamSubscription listener;

  @override
  void onReady() async {
    super.onReady();
    listener =
        InternetConnection().onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
          if (watchViewController.isCachedUsed.value) {
            showRefresh.value = true;
          } else {
            showRefresh.value = false;
          }
          break;
        case InternetStatus.disconnected:
          break;
      }
    });
  }
}
