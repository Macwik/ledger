import 'package:get/get.dart';

import 'daily_account_cost_detail_controller.dart';

class DailyAccountCostDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DailyAccountCostDetailController());
  }
}
