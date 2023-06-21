import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:transportation_rent_mobile/view/page/homePage.dart';

class MaterialDialogWidget {
  static Future<void> signatureDialog(BuildContext context) {
    return Dialogs.materialDialog(
        msg: 'Jika Keluar data yang dibuat akan di hapus.',
        msgAlign: TextAlign.center,
        title: "Peringatan!",
        titleStyle: TextStyle(
          color: Color(0xFFF8BB04),
          fontWeight: FontWeight.w700,
          fontSize: 19,
        ),
        color: Colors.white,
        context: context,
        actions: [
          IconsOutlineButton(
            onPressed: () {
              Get.back();
            },
            text: 'Batal',
            iconData: Icons.cancel_outlined,
            textStyle: TextStyle(color: Colors.grey),
            iconColor: Colors.grey,
          ),
          IconsButton(
            onPressed: () {
              Get.offAll(HomePage());
            },
            text: 'Keluar',
            iconData: Icons.logout,
            color: const Color(0xFFDB372C),
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }
}
