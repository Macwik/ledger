import 'package:get/get.dart';

import 'decimal_setting_controller.dart';

class DecimalSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DecimalSettingController());
  }
}
