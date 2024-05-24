import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/cost_income_api.dart';
import 'package:ledger/enum/cost_order_type.dart';
import 'package:ledger/enum/is_select.dart';
import 'package:ledger/res/export.dart';

import 'cost_bill_state.dart';

class CostBillController extends GetxController {
  final CostBillState state = CostBillState();
  var currentTab = 0.obs;

  Future<void> initState() async {
    var arguments = Get.arguments;
    if (arguments != null && arguments['costOrderType'] != null) {
      state.costOrderType = arguments['costOrderType'];
    }
  }

  Future<void> toCheckPayWay() async {
    var result = await Get.toNamed(RouteConfig.paymentManage,
        arguments: {'isSelect': IsSelectType.TRUE});

    state.bankDTO = result;
    update(['paymentWay']);
  }

  void changeTab(int index) {
    currentTab.value = index;
  }

  Future<void> addCost() async {
    if (!state.formKey.currentState!.saveAndValidate(focusOnInvalid: false)) {
      return;
    }
    if (null == state.bankDTO) {
      Toast.show('请选择支付方式');
      return;
    }
    if ((state.orderDTO != null) && (state.bindingProduct?.isEmpty ?? true)) {
      Toast.show('请选择绑定货物');
      return;
    }
    Loading.showDuration();
    await Http().network(Method.post, CostIncomeApi.add_cost_order, data: {
      'orderType': state.costOrderType?.value,
      'labelId': state.costLabel?.id,
      'costIncomeName': state.textEditingController.text,
      'totalAmount': state.amountController.text,
      'discount': state.selectedOption ?? 1,
      'orderPaymentRequest': [
        {
          'paymentMethodId': state.bankDTO!.id,
          'paymentAmount': state.amountController.text,
          'ordinal': 0
        }
      ],
      'orderDate': DateUtil.formatDate(state.date, format: DateFormats.y_mo_d),
      'salesOrderId': state.orderDTO?.id,
      'salesOrderNo': state.orderDTO?.orderNo,
      'productIdList': state.bindingProduct?.map((e) => e.productId).toList(),
      'remark': state.remarkController.text,
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        Toast.show('费用开单成功');
        Get.back();
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  Future<void> toSelectCostType() async {
    var result =
        await Get.toNamed(RouteConfig.costType, arguments: {'costOrderType': state.costOrderType});
    state.costLabel = result;
    if (state.textEditingController.text.isEmpty) {
      state.textEditingController.text = state.costLabel?.labelName ?? '';
    }
    update(['costType']);
  }

//绑定采购单
  Future<void> toBindingPurchaseBill() async {
    state.bindingProduct = null;
    var result = await Get.toNamed(RouteConfig.bindingSaleBill);
    if(result != null){
      state.orderDTO = result['salesOrder'];
      state.bindingProduct = result['productList'];
    }
    update(['bindingPurchaseBill', 'bindingPurchaseProduct']);
  }


  void onFormChange() {
    state.formKey.currentState?.saveAndValidate(focusOnInvalid: false);
    update(['costBillBtn']);
  }

  String getBindingProductNames() {
    if (state.bindingProduct?.isEmpty ?? true) {
      return '请通过采购单绑定货物';
    }
    return state.bindingProduct!.map((e) => e.productName).toList().join(',');
  }


  Future<void> pickerDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        confirmText: '确定',
        initialDate: DateTime.now(),
        // 设置初始日期
        firstDate: DateTime(2000),
        // 设置日期范围的开始日期
        lastDate: DateTime.now(),
        // 设置日期范围的结束日期
        builder: (BuildContext context, Widget? child) {
          return child!;
        });
    if (picked != null) {
      state.date = picked;
      update(['bill_date']);
    }
  }

  void costBillGetBack() {
    if ((state.costLabel != null) ||
        (state.bankDTO != null) ||
        (state.bindingProduct != null) ||
        (state.orderDTO != null) ||
        (state.amountController.text.isNotEmpty) ||
        (state.remarkController.text.isNotEmpty )) {
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

  //选择费用扣除位置
  void selectProductPosition(int optionItem) {
    state.selectedOption = optionItem;
    update(['cost_bill_select_product_position']);
  }

  void explainPayment() {
    Get.dialog(AlertDialog(
        title: Text('支付地间的区别'),
        content: Text('''销售地支付：会把销售地支付费用扣减到每天结账账款中,
            
产地支付：不会把产地支付费用扣减到每天结账账款中''',
            style: TextStyle(
              color: Colours.text_333,
              fontSize: 32.sp,
            )),
        // Text('产地支付：不会把产地支付费用扣减到每天结账账款中'),

        actions: [
          TextButton(
            child: Text('了解了'),
            onPressed: () {
              Get.back();
            },
          ),
        ]));
  }
}
