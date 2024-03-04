import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/custom_api.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/res/export.dart';

import 'custom_detail_state.dart';

class CustomDetailController extends GetxController {
  final CustomDetailState state = CustomDetailState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['customId'] != null) {
      state.customId = arguments['customId'];
    }
    _queryData();
  }

  _queryData() {
    Http().network<CustomDTO>(Method.post, CustomApi.getCustomDetail,
        queryParameters: {'id': state.customId}).then((result) {
      if (result.success) {
        state.customDTO = result.d;
        state.nameController.text = result.d?.customName ??'';
      state.phoneController.text = result.d?. phone??'';
      state.addressController.text = result.d?.address ??'';
      state.remarkController.text = result.d?.remark ??'';
        update(['custom_detail', 'custom_detail_title']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  void onEdit() {
    state.isEdit = !state.isEdit;
    update(['custom_detail', 'custom_btn', 'custom_edit']);
  }

  void updateCustom() {
    String? customName = state.nameController.text;
    String? customPhone = state.phoneController.text;
    String? customAddress = state.addressController.text;
    String? customRemark = state.remarkController.text;

    Loading.showDuration();
    Http().network(Method.put, CustomApi.updateCustom, data: {
      'id': state.customDTO?.id,
      'customName': customName,
      'phone': customPhone,
      'address': customAddress,
      'remark': customRemark,
      'customType': state.customDTO?.customType,
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        state.isEdit = !state.isEdit;
        _queryData();
        update(['custom_edit', 'custom_btn', 'custom_detail']);
      } else {
        Toast.show('保存失败');
      }
    });
  }

  //停用客户
  void toInvalidCustom() {
    Get.dialog(
      Warning(
        cancel: '取消',
        confirm: '确定',
        content: state.customDTO?.invalid == 0 ? '确认停用此客户吗？' : '确定启用此客户吗？',
        onCancel: () => Get.back(),
        onConfirm: () {
          if (state.customDTO?.invalid == 0) {
            Http()
                .network(Method.put, CustomApi.customInvalid, queryParameters: {
              'id': state.customDTO?.id,
            }).then((result) {
              if (result.success) {
                Toast.show('成功停用');
                _queryData();
                Get.back();
              } else {
                Toast.show(result.m.toString());
              }
            });
          } else {
            Http()
                .network(Method.put, CustomApi.customEnable, queryParameters: {
              'id': state.customDTO?.id,
            }).then((result) {
              if (result.success) {
                Toast.show('成功启用');
                _queryData();
                Get.back(result: ProcessStatus.OK);
              } else {
                Toast.show(result.m.toString());
              }
            });
          }
        },
      ),
      barrierDismissible: false,
    );
  }

  void customDetailGetBack() {
    if(state.isEdit){
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
      Get.back(result: ProcessStatus.FAIL);
    }
  }
}
