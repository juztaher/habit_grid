import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  late RxBool isConnected;

  @override
  void onInit() {
    super.onInit();
    isConnected = true.obs;

    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      bool hasConnection = result.isNotEmpty &&
          result.any((element) => element != ConnectivityResult.none);
      isConnected.value = hasConnection;

      if (!hasConnection) {
        Get.snackbar(
          "No Internet",
          "Please check your internet connection.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        if (Get.isSnackbarOpen) {
          Get.closeCurrentSnackbar();
        }
      }
    });
  }

  bool get isOnline => isConnected.value;
}
