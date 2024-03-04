import 'package:get/get.dart';

import 'account_setting_controller.dart';

class AccountSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountSettingController());
  }
}
