import 'package:get/get.dart';

class RefreshController extends GetxController {
  RxBool shouldRefresh = false.obs;

  void refresh() {
    shouldRefresh.toggle();
  }
}
