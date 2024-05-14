import 'package:get/get.dart';
import 'package:ledger/config/api/user_api.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/loading.dart';

import 'first_index_state.dart';

class FirstIndexController extends GetxController {
  final FirstIndexState state = FirstIndexState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['phone'] != null) {
      state.phone = arguments['phone'];
    }
  }


  void onFormChange() {
    state.formKey.currentState?.saveAndValidate(focusOnInvalid: false);
    update(['first_index_btn']);
  }

  registerUserAndRedirect() async {
    Loading.showDuration();
    final result =
        await Http().network<void>(Method.post, UserApi.register, data: {
      'phone': state.phone,
      'channel': 1,
      'password': state.passwordController.text,
      'username': state.nameController.text,
      'gender': 2 //未知
    });
    Loading.dismiss();
    if (result.success) {
      Get.offAllNamed(RouteConfig.addAccount,arguments: {'firstIndex':true});
    } else {
      Toast.showError(result.m.toString());
    }
    // Get.toNamed(RouteConfig.addAccount,arguments: {'firstIndex':true});
  }


}
