import 'package:get/get.dart';

import 'cost_type_controller.dart';

class CostTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CostTypeController());
  }
}
