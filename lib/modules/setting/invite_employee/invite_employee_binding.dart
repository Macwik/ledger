import 'package:get/get.dart';

import 'invite_employee_controller.dart';

class InviteEmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InviteEmployeeController());
  }
}
