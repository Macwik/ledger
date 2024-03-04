import 'package:get/get.dart';

import 'add_custom_controller.dart';

class AddCustomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddCustomController());
  }
}
