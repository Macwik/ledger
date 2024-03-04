import 'package:get/get.dart';

import 'store_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<StoreController>(StoreController(), permanent: true);
  }
}
