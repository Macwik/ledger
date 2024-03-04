import 'package:get/get.dart';

import 'mine_detail_controller.dart';

class MineDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MineDetailController());
  }
}
