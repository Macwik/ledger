import 'package:get/get.dart';

import 'add_role_controller.dart';

class AddRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddRoleController());
  }
}
