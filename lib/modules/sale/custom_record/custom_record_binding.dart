import 'package:get/get.dart';

import 'custom_record_controller.dart';

class CustomRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<CustomRecordController>(() => CustomRecordController(), permanent: false);
  }
}
