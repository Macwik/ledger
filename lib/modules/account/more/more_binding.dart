import 'package:get/get.dart';

import 'more_controller.dart';

class MoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<MoreController>(() => MoreController(), permanent: false);
  }
}
