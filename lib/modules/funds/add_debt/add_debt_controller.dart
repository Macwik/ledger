import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/repayment_api.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/res/export.dart';

import 'add_debt_state.dart';

class AddDebtController extends GetxController {
  final AddDebtState state = AddDebtState();

  void initState()  {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['customDTO'] != null) {
      state.customDTO = arguments['customDTO'];
    }
    update(['custom']);
  }

  void addDebt() {
    if (!state.formKey.currentState!.saveAndValidate(focusOnInvalid: false)) {
      return;
    }
    String? debtMoney = state.formKey.currentState!.fields['debtMoney']?.value;
    String? debtRemark = state.formKey.currentState!.fields['debtRemark']?.value;
    if (null == state.customDTO?.customName) {
      Toast.show('请选择欠款人');
      return;
    }
    Loading.showDuration();
    Http().network(Method.post,RepaymentApi.add_debt, data: {
      'creditType': OrderType.CREDIT.value,
      'customId': state.customDTO?.id ,
      'creditDate':DateUtil.formatDate(state.date, format: DateFormats.y_mo_d),
      'creditAmount': debtMoney,
      'Remark': debtRemark,
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        Get.back();
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  void onFormChange() {
    state.formKey.currentState?.saveAndValidate(focusOnInvalid: false);
    update(['Debt_btn']);
  }

  Future<void> pickerDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // 设置初始日期
      firstDate: DateTime(2000), // 设置日期范围的开始日期
      lastDate: DateTime(2100), // 设置日期范围的结束日期
    );
    if (picked != null) {
      state.date = picked;
      update(['bill_date']);
    }
  }

 Future<void> chooseCustom() async {
   var result = await Get.toNamed(RouteConfig.customRecord,
       arguments: {'initialIndex': 0,'isSelectCustom': true,'orderType':OrderType.CREDIT});
   if (result != null) {
     state.customDTO = result;
     update(['custom']);
   }
 }

  void addDebtGetBack() {
    String? debtMoney = state.formKey.currentState?.fields['debtMoney']?.value;
    String? debtRemark = state.formKey.currentState?.fields['debtRemark']?.value;
    if((state.customDTO != null) || (debtRemark?.isNotEmpty ?? false )|| (debtMoney?.isNotEmpty ?? false)){
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
                  Get.until((route) {
                    return( route.settings.name == RouteConfig.main)
                    || ( route.settings.name == RouteConfig.funds);
                });}),
          ]));
    } else {
      Get.back();
    }
  }

}
