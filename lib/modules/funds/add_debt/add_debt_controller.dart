import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/repayment_api.dart';
import 'package:ledger/enum/custom_type.dart';
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
    if (null == state.customDTO?.customName) {
      Toast.show('请选择欠款人');
      return;
    }
    Loading.showDuration();
    Http().network(Method.post,RepaymentApi.add_debt, data: {
      'creditType': OrderType.CREDIT.value,
      'customId': state.customDTO?.id ,
      'creditDate':DateUtil.formatDate(state.date, format: DateFormats.y_mo_d),
      'creditAmount': state.amountController.text,
      'Remark': state.remarkController.text,
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
   var result = await Get.toNamed(RouteConfig.chooseCustom,
       arguments: {'customType': CustomType.CUSTOM.value,'isSelectCustom': true,'orderType':OrderType.CREDIT});
   if (result != null) {
     state.customDTO = result;
     update(['custom']);
   }
 }

  void addDebtGetBack() {
    if((state.customDTO != null) || (state.remarkController.text.isNotEmpty)
        || (state.amountController.text.isNotEmpty )){
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
