import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/custom_api.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/res/export.dart';

import 'add_custom_state.dart';

class AddCustomController extends GetxController {
  final AddCustomState state = AddCustomState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['customType'] != null) {
      state.customType = arguments['customType'];
    }
  }

  void onFormChange() {
    state.formKey.currentState?.saveAndValidate(focusOnInvalid: false);
    update(['custom_btn']);
  }
  void addCustom() {
    if (!state.formKey.currentState!.saveAndValidate(focusOnInvalid: false)) {
      return;
    }
    Loading.showDuration();
    Http().network(Method.post, CustomApi.addCustom, data: {
      'customName': state.nameController.text,
      'phone': state.phoneController.text,
      'address': state.addressController.text,
      'remark': state.remarkController.text,
      'customType': state.customType,
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        Get.back(result: ProcessStatus.OK);
      } else {
        Get.back(result: ProcessStatus.FAIL);
        Toast.show(result.m.toString());
      }
    });
  }

  void addCustomGetBack() {
    if((state.nameController.text.isNotEmpty)
        ||(state.phoneController.text.isNotEmpty)
        ||(state.addressController.text.isNotEmpty)
        || (state.remarkController.text.isNotEmpty)){
      Get.dialog(
          AlertDialog(
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
                  },
                ),
              ]));
    }else{
      Get.back();
    }
  }
}
