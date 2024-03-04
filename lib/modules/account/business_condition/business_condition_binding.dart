import 'package:get/get.dart';

import 'business_condition_controller.dart';

class BusinessConditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BusinessConditionController());
  }
}
