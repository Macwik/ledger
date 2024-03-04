import 'package:get/get.dart';

import 'account_detail_controller.dart';

class AccountDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountDetailController());
  }
}
