import 'package:get/get.dart';

import 'logout_app_controller.dart';

class LogoutAppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LogoutAppController());
  }
}
