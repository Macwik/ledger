import 'package:get/get.dart';
import 'package:ledger/modules/login/register/register_controller.dart';


class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<RegisterController>(() => RegisterController(), permanent: false);
  }
}
