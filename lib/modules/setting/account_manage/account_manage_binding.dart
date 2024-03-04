import 'package:get/get.dart';

import 'account_manage_controller.dart';

class AccountManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountManageController());
  }
}
