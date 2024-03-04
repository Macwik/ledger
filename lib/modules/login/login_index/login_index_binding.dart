import 'package:get/get.dart';
import 'package:ledger/modules/login/login_index/login_index_controller.dart';

class LoginIndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginIndexController());
  }
}
