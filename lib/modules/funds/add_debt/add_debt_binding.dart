import 'package:get/get.dart';

import 'add_debt_controller.dart';

class AddDebtBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddDebtController());
  }
}
