import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/user_api.dart';
import 'package:ledger/entity/user/user_detail_dto.dart';
import 'package:ledger/enum/change_status.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/store/store_controller.dart';
import 'package:ledger/widget/dialog/single_input_dialog.dart';

import 'mine_detail_state.dart';

class MineDetailController extends GetxController {
  final MineDetailState state = MineDetailState();

  Future<void> logout() async {
    final result = await Http().network<void>(Method.post, UserApi.logout);
    if (result.success) {
      StoreController.to.signOut();
      Get.offAllNamed(RouteConfig.loginVerify);
    }else{
      Toast.show('网络错误，请稍后再试');
    }
  }

  Future<void> initState() async {
    _queryData();
  }

  _queryData() {
    Http()
        .network<UserDetailDTO>(Method.get, UserApi.user_detail)
        .then((result) {
      if (result.success) {
        state.userDetailDTO = result.d;
        update(['user_detail_name']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  void editNickName() {
    var user = state.user;
    SingleInputDialog().singleInputDialog(
      title: '修改昵称',
      hintText: user?.username ?? '',
      keyboardType: TextInputType.emailAddress,
      validator: FormBuilderValidators.required(errorText: '昵称不能为空'.tr),
      onOkPressed: (value) async {
        Loading.showDuration();
        final result = await Http().network<void>(
            Method.put, UserApi.edit_nickname,
            queryParameters: {'username': value});
        Loading.dismiss();
        if (result.success) {
          _queryData();
          StoreController.to.updateUser(value).then((value) {
            state.changeStatus = ChangeStatus.CHANGE;
          });
          Toast.show('修改成功');
          return true;
        } else {
          Toast.show(result.m.toString());
          return false;
        }
      },
    );
  }

  void changePhone() {
    Get.dialog(
      Warning(
        cancel: '取消',
        confirm: '复制微信号',
        content: '请联系客服，微信号：lulu0675',
        onCancel: () {},
        onConfirm: () {
          Clipboard.setData(ClipboardData(text: 'lulu0675'));
        },
      ),
      barrierDismissible: false,
    );
  }

}
