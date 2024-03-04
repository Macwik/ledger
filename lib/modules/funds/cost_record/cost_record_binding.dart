import 'package:get/get.dart';

import 'cost_record_controller.dart';

class CostRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CostRecordController());
  }
}
