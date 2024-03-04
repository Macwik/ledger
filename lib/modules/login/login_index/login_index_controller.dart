import 'package:get/get.dart';

import 'package:ledger/route/route_config.dart';
import 'login_index_state.dart';

class LoginIndexController extends GetxController {
  final LoginIndexState state = LoginIndexState();


  void toForgetPassword() {
    Get.toNamed(RouteConfig.forgetPassword);
  }

  void toLoginVerify(){ Get.toNamed(RouteConfig.loginVerify);}

  void toRegister() {
    Get.toNamed(RouteConfig.register);
  }
}
