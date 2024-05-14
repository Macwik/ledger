import 'package:get/get.dart';

import 'choose_custom_controller.dart';

class ChooseCustomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChooseCustomController());
  }
}
