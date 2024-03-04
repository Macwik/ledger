import 'package:get/get.dart';

import 'auth_update_controller.dart';

class AuthUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthUpdateController());
  }
}
