import 'package:get/get.dart';

import 'custom_list_controller.dart';

class CustomListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomListController());
  }
}
