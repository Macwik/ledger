import 'package:get/get.dart';

import 'login_verify_controller.dart';

class LoginVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginVerifyController());
  }
}
