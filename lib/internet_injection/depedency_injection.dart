import 'package:get/get.dart';
import 'package:transportation_rent_mobile/controllers/network_controller.dart';

class DepedencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
