import 'package:get/get.dart';

import 'my_account_controller.dart';

class MyAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyAccountController());
  }
}
