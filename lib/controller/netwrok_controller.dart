import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:img_gallaries_mini_app/util/app_color.dart';

/// Handle network for the whole app
class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();

    /// Check network if stream is not listen
    /// Check only 1 time
    _connectivity
        .checkConnectivity()
        .then((value) => _updateConnectionStatus(value));

    /// Check network if stream is listen
    ///
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar("No internet connection".toUpperCase(),
          "Please connect to the internet",
          icon: const Icon(Icons.wifi_off, color: Colors.red, size: 35),
          duration: const Duration(days: 1),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColor.mainColor,
          isDismissible: false);
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
