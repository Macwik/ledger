import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/ledger_api.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/store/store_controller.dart';

import 'add_account_state.dart';

class AddAccountController extends GetxController {
  final AddAccountState state = AddAccountState();

  bool isSelectedBusinessScope(int index) {
    return state.selectedBusinessScope == index;
  }

  bool isSelectedStoreType(int index) {
    return state.selectedStore == index;
  }

  void changeBusinessScope(int index) {
    state.selectedBusinessScope = index;
    update(['businessScope']);
  }

  void changeStoreType(int index) {
    state.selectedStore = index;
    update(['storeType']);
  }

  void onFormChange() {
    state.formKey.currentState?.saveAndValidate(focusOnInvalid: false);
    update(['saveBtn']);
  }

  void addAccount() {
    if (!state.formKey.currentState!.saveAndValidate(focusOnInvalid: false)) {
      return;
    }
    String? ledgerName = state.formKey.currentState!.fields['account_name']?.value;
    Loading.showDuration();
    Http().network<int>(Method.post, LedgerApi.add_ledger, data: {
      'ledgerName': ledgerName,
      'storeType': state.selectedStore,
      'businessScope': state.selectedBusinessScope,
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        var activeLedgerId = StoreController.to.getActiveLedgerId();
        if (null == activeLedgerId) {
          Get.defaultDialog(
              title: '提醒',
              barrierDismissible: false,
              middleText: '设置当前账本为活跃账本吗？',
              onCancel: () {
                Get.back();
                Get.back(result: ProcessStatus.OK);
              },
              onConfirm: () {
                Http().network(Method.put, LedgerApi.ledger_change,
                    queryParameters: {
                      'ledgerId': result.d,
                    }).then((result) {
                  if (result.success) {
                    Get.defaultDialog(
                        title: '提示',
                        barrierDismissible: false,
                        middleText: '账本切换成功, 请重新登录',
                        onConfirm: () {
                          StoreController.to.signOut();
                          Get.offAllNamed(RouteConfig.loginVerify);
                        });
                  } else {
                    Toast.show(result.m.toString());
                    Get.back(result: ProcessStatus.OK);
                  }
                });
              });
        }else{
          Get.back(result: ProcessStatus.OK);
        }
      } else {
        Get.back(result: ProcessStatus.FAIL);
        Toast.show(result.m.toString());
      }
    });
  }

  void addAccountGetBack() {
    String? ledgerName =
        state.formKey.currentState?.fields['account_name']?.value;
    if (ledgerName?.isNotEmpty ?? false) {
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
