import 'package:get/get.dart';

import 'remittance_controller.dart';

class RemittanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemittanceController());
  }
}
