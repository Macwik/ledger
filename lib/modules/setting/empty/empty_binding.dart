import 'package:get/get.dart';

import 'empty_controller.dart';

class EmptyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmptyController());
  }
}
