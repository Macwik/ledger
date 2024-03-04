import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/ledger_api.dart';
import 'package:ledger/entity/ledger/user_ledger_dto.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/util/toast_util.dart';

import 'account_manage_state.dart';

class AccountManageController extends GetxController {
  final AccountManageState state = AccountManageState();

  Future<void> initState() async{
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['ledgerId'] != null) {
      state.ledgerId = arguments['ledgerId'];
    }
    _queryData();
  }

  _queryData() {
    Http().network<LedgerUserRelationDetailDTO>(
        Method.post, LedgerApi.ledger_detail,
        queryParameters: {'ledgerId':state.ledgerId}).then((result) {
      if (result.success) {
        state.ledgerUserRelationDetailDTO = result.d;
        update(['account_btn','account_edit', 'account_detail',
        ]);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }


  void changeStoreType(int index) {
    state.selectedStore = index;
    update(['storeType']);
  }

  void onEdit() {
    state.isEdit = !state.isEdit;
    update(['account_detail', 'account_btn','account_edit']);
  }

  void changeBusinessScope(int index) {
  state.selectedBusinessScope = index;
  update(['businessScope']);
  }

  bool isSelectedStoreType(int index) {
    if(state.isEdit){
      return state.selectedStore == index;
    }else{
      if( ( state.ledgerUserRelationDetailDTO != null) && ( state.ledgerUserRelationDetailDTO!.storeType != null) ){
        return  index == state.ledgerUserRelationDetailDTO!.storeType!;
      }else{
        return true;
      }
    }
  }

  bool isSelectedBusinessScope(int index) {
    if(state.isEdit){
      return state.selectedBusinessScope == index;
    }else{
      if( ( state.ledgerUserRelationDetailDTO != null) && ( state.ledgerUserRelationDetailDTO!.businessScope != null) ){
        return  index == state.ledgerUserRelationDetailDTO!.businessScope!;
      }else{
        return true;
      }
    }
  }

  void updateAccount() {
    if (!state.formKey.currentState!.saveAndValidate(focusOnInvalid: false)) {
      return;
    }
    String? ledgerName = state.nameController?.text;
    Http().network(Method.put, LedgerApi.update_ledger, data: {
      'ledgerId':state.ledgerUserRelationDetailDTO?.ledgerId,
      'ledgerName': ledgerName,
      'storeType': state.selectedStore,
      'businessScope': state.selectedBusinessScope,
    }).then((result) {
      if (result.success) {
        Get.back(result: ProcessStatus.OK);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  void accountManageGetBack() {
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
