import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/remittance_api.dart';
import 'package:ledger/entity/payment/order_payment_request.dart';
import 'package:ledger/enum/is_select.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/modules/purchase/stock_list/stock_list_state.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/toast_util.dart';

import 'remittance_state.dart';

class RemittanceController extends GetxController {
  final RemittanceState state = RemittanceState();

  void onFormChange() {
    state.formKey.currentState?.saveAndValidate(focusOnInvalid: false);
    update(['remittance_btn']);
  }

  Future<void> pickerDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        // 设置初始日期
        firstDate: DateTime(2000),
        // 设置日期范围的开始日期
        lastDate: DateTime(2100),
        // 设置日期范围的结束日期
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              highlightColor: Theme.of(context).primaryColor, // 使用主题色作为高亮色
              colorScheme: ThemeData.light().colorScheme.copyWith(
                    primary: Theme.of(context).primaryColor, // 使用主题色作为主要颜色
                    onPrimary: Colors.white, // 设置主要颜色的文本颜色
                  ),
            ),
            child: child!,
          );
        });
    if (picked != null) {
      state.date = picked;
      update(['date']);
    }
  }

  void addRemittance() {
    if (null == state.paymentMethodDTO?.name) {
      Toast.show('请选择支付方式');
      return;
    }
    Http().network(Method.post, RemittanceApi.add_remittance, data: {
      'receiver': state.receiverController.text,
      'amount': Decimal.tryParse(state.amountController.text),
      'productIdList':
          (state.productDTO == null || state.productDTO?.id == null)
              ? null
              : [state.productDTO?.id],
      'paymentRequest': [
        OrderPaymentRequest(
            paymentMethodId: state.paymentMethodDTO?.id,
            paymentAmount: Decimal.tryParse(state.amountController.text),
            ordinal: 1)
      ],
      'remittanceDate': DateUtil.formatDefaultDate(state.date),
      'remark': state.remarkController.text,
    }).then((result) {
      if (result.success) {
        Get.offNamed(RouteConfig.remittanceRecord);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  Future<void> toStockList() async {
    await Get.toNamed(RouteConfig.stockList,
        arguments: {'select': StockListType.SELECT_PRODUCT})?.then((result) {
      if (result != null) {
        state.productDTO = result;
        update(['productName']);
      }
    });
  }

  Future<void> selectBank() async {
    var result = await Get.toNamed(RouteConfig.paymentManage,
        arguments: {'isSelect': IsSelectType.TRUE});
    state.paymentMethodDTO = result;
    update(['repayment_way']);
  }

  void remittanceGetBack() {
    if ((state.paymentMethodDTO != null) ||
        (state.productDTO != null) ||
        (state.receiverController.text.isNotEmpty) ||
        (state.amountController.text.isNotEmpty) ||
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
