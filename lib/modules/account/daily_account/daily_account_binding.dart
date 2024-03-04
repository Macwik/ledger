import 'package:get/get.dart';

import 'daily_account_controller.dart';

class DailyAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<DailyAccountController>(() => DailyAccountController(),
        permanent: false);
  }
}
