import 'package:get/get.dart';

import 'funds_controller.dart';

class FundsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FundsController());
  }
}
