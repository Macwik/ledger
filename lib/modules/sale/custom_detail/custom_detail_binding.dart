import 'package:get/get.dart';

import 'custom_detail_controller.dart';

class CustomDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomDetailController());
  }
}
