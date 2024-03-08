import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/auth_api.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/modules/setting/add_role/add_role_state.dart';
import 'package:ledger/res/export.dart';

class AddRoleController extends GetxController {
  final AddRoleState state = AddRoleState();

  Future<void> addRole() async {
    Loading.showDuration();
    final result = await Http().network<void>(Method.post, AuthApi.add_role,
        data: {'roleName': state.nameController.text, 'roleDesc': state.remarkController.text});
    if (result.success) {
      Loading.dismiss();
      Get.back(result: ProcessStatus.OK);
    } else {
      Toast.show(result.m.toString());
    }
  }

  void onFormChange() {
    state.formKey.currentState?.saveAndValidate(focusOnInvalid: false);
    update(['add_role_btn']);
  }

 void addRoleGetBack() {
    if ((state.nameController.text.isNotEmpty) ||
        (state.remarkController.text.isNotEmpty)) {
      Get.dialog(AlertDialog(
          title: Text('是否确认退出'),
          content: Text('退出后将无法恢复'),
          actions: [
            TextButton(
              child: Text('取消'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
                child: Text('确定'),
                onPressed: () {
                  Get.back();
                  Get.back();
                }),
          ]));
    } else {
      Get.back();
    }
  }
}
