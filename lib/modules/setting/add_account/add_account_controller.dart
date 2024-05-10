import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/ledger_api.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/res/export.dart';

import 'add_account_state.dart';

class AddAccountController extends GetxController {
  final AddAccountState state = AddAccountState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['firstIndex'] != null) {
      state.firstIndex = arguments['firstIndex'];
    }
    update(['add_account_form']);
  }

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
    Loading.showDuration();
    Http().network<int>(Method.post, LedgerApi.add_ledger, data: {
      'ledgerName': state.nameController.text,
      'storeType': state.selectedStore,
      'businessScope': state.selectedBusinessScope,
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        if(state.firstIndex){//ToDo 不走这儿的代码
              Get.back(result: ProcessStatus.OK);
            }else{
              Get.toNamed(RouteConfig.myAccount);
            }
        // var activeLedgerId = StoreController.to.getActiveLedgerId();
        // if (null == activeLedgerId) {
        //   Get.defaultDialog(
        //       title: '提醒',
        //       barrierDismissible: false,
        //       middleText: '设置当前账本为活跃账本吗？',
        //       textCancel: '否',
        //       textConfirm: '是',
        //       onCancel: () {
        //         Get.back();
        //         Get.back(result: ProcessStatus.OK);
        //       },
        //       onConfirm: () {
        //         Http().network(Method.put, LedgerApi.ledger_change,
        //             queryParameters: {
        //               'ledgerId': result.d,
        //             }).then((result) {
        //           if (result.success) {
        //             Get.defaultDialog(
        //                 title: '提示',
        //                 barrierDismissible: false,
        //                 middleText: '账本切换成功, 请重新登录',
        //                 textConfirm: '确定',
        //                 onConfirm: () {
        //                   StoreController.to.signOut();
        //                   Get.offAllNamed(RouteConfig.loginVerify);
        //                 });
        //           } else {
        //             Toast.show(result.m.toString());
        //             Get.back(result: ProcessStatus.OK);
        //           }
        //         });
        //       });
        // }else{
        //   if(!state.firstIndex){
        //     Get.back(result: ProcessStatus.OK);
        //   }else{
        //     Get.toNamed(RouteConfig.myAccount);
        //   }
        // }
      } else {
        if(!state.firstIndex){
          Get.back(result: ProcessStatus.FAIL);
          Toast.show(result.m.toString());
            }else{
          Toast.show(result.m.toString());
            }
      }
    });
  }

  void addAccountGetBack() {
    if (state.nameController.text.isNotEmpty ) {
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
