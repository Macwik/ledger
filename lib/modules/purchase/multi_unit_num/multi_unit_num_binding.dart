import 'package:get/get.dart';

import 'multi_unit_num_controller.dart';

class MultiUnitNumBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MultiUnitNumController());
  }
}
