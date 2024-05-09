import 'package:get/get.dart';

import 'first_index_controller.dart';

class FirstIndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FirstIndexController());
  }
}
