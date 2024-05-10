import 'package:get/get.dart';

import 'choose_account_controller.dart';

class ChooseAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChooseAccountController());
  }
}
