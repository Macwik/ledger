import 'package:get/get.dart';

import 'remittance_detail_controller.dart';

class RemittanceDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemittanceDetailController());
  }
}
