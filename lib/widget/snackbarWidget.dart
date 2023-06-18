import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarWidget {
  void snackbarSuccess(String msg) {
    Get.showSnackbar(
      GetSnackBar(
        title: "Berhasil",
        message: msg,
        icon: const Icon(
          Icons.check,
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void snackbarError(String msg) {
    Get.showSnackbar(
      GetSnackBar(
        title: "Error",
        message: msg,
        icon: const Icon(
          Icons.error_outline,
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void snackbar() {
    // if(){

    // }else{
    //   if (Get.isSnackbarOpen) {
    //     Get.closeCurrentSnackbar();
    //   }
    // }
    Get.rawSnackbar(
      title: "Error",
      message: "Server Error",
      icon: const Icon(Icons.error_outline),
      backgroundColor: Colors.red,
    );
  }
}
