import 'package:get/get.dart';

import 'goods_detail_controller.dart';

class GoodsDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GoodsDetailController());
  }
}
