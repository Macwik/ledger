import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/custom_api.dart';
import 'package:ledger/config/api/repayment_api.dart';
import 'package:ledger/config/api/setting_api.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/entity/repayment/custom_credit_dto.dart';
import 'package:ledger/entity/setting/sales_line_dto.dart';
import 'package:ledger/enum/is_select.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/store/store_controller.dart';
import 'package:ledger/util/decimal_util.dart';

import 'repayment_bill_state.dart';

class RepaymentBillController extends GetxController {
  final RepaymentBillState state = RepaymentBillState();

  void initState() {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['customType'] != null) {
      state.customType = arguments['customType'];
    }
    if ((arguments != null) && arguments['customId'] != null) {
      state.customId = arguments['customId'];
      _queryData();
    }
    // if ((arguments != null) && arguments['index'] != null) {
    //   state.index = arguments['index'];
    //   if( state.index== 0){
    //     state.customType = CustomType.CUSTOM.value;
    //   }else{
    //     state.customType = CustomType.SUPPLIER.value;
    //   }
    // }
    _querySalesLineConfig();
    update(['repayment_custom_type']);
  }

  Future<void> _querySalesLineConfig() async {
    final result = await Http()
        .network<SalesLineDTO>(Method.get, SettingApi.GET_REPAYMENT_TIME);
    if (result.success) {
      state.salesLineDTO = result.d!;
    } else {
      Toast.show(result.m.toString());
    }
  }

  _queryData() {
    Http().network<CustomDTO>(Method.post, CustomApi.supplier_detail_title,
        queryParameters: {
          'id': state.customId,
        }).then((result) {
      if (result.success) {
        state.customDTO = result.d;
        update(['repayment_bill_credit_amount', 'repayment_custom']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  void onFormChange() {
    state.formKey.currentState?.saveAndValidate(focusOnInvalid: false);
    update(['custom_btn']);
  }

  Future<void> addRepayment() async {
    /// 判断时间是否合法
    if (!check()) {
      Get.defaultDialog(
          title: '时间不支持还款', // 设置标题为null，即不显示标题
          middleText: '老板账本中：设置-记账设置-还款时间，可修改还款时间 ',
          onConfirm: () {
            Get.back();
          });
      return;
    }

    //填写内容判断
    if (!state.formKey.currentState!.saveAndValidate(focusOnInvalid: false)) {
      return;
    }
    String discount = state.discountController.text;
    String? remark = state.formKey.currentState!.fields['remark']?.value;
    String paymentAmount = state.repaymentController.text;
    //填写的总金额
    Decimal? inputAmount = Decimal.tryParse(paymentAmount);
    Decimal? discountAmount = Decimal.tryParse(discount);
    if (inputAmount == null && discountAmount == null) {
      await Get.defaultDialog(
          title: '提示', // 设置标题为null，即不显示标题
          middleText: '请正确填写还款金额与优惠金额',
          onConfirm: () {
            Get.back();
          });
      return;
    }
    //判断填写内容是否合规
    if (IsSelectType.TRUE == state.isSelect &&
        (state.customCreditDTO?.isNotEmpty ?? false)) {
      // 按单结算
      Decimal? selectAmount = state.customCreditDTO
          ?.map((e) => e.repaymentAmount ?? Decimal.zero)
          .reduce((previous, current) => previous + current);
      if (null == selectAmount) {
        await Get.defaultDialog(
            title: '提示', // 设置标题为null，即不显示标题
            middleText: '请正确选择欠款单据',
            onConfirm: () {
              Get.back();
            });
        return;
      }
      if ((inputAmount ?? Decimal.zero) + (discountAmount ?? Decimal.zero) !=
          selectAmount) {
        await Get.defaultDialog(
            title: '提示', // 设置标题为null，即不显示标题
            middleText: '优惠金额加收款金额应等于选择的收款单据金额',
            onConfirm: () {
              Get.back();
            });
        return;
      }
    } else {
      //还款金额不能大于总欠款金额
      var totalAmount =
          (inputAmount ?? Decimal.zero) + (discountAmount ?? Decimal.zero);
      if (totalAmount > (state.customDTO?.creditAmount ?? Decimal.zero)) {
        await Get.defaultDialog(
            title: '提示', // 设置标题为null，即不显示标题
            middleText: '还款金额不能大于总欠款金额',
            onConfirm: () {
              Get.back();
            });
        return;
      }
      if ((Decimal.zero) >= (inputAmount ?? Decimal.zero)) {
        Toast.show('收款金额应大于零');
        return;
      }
    }
    if (null == state.customDTO) {
      Toast.show('请选择客户');
      return;
    }
    if (null == state.paymentMethodDTO) {
      Toast.show('请选择收款账户');
      return;
    }
    Loading.showDuration();
    await Http().network(Method.post, RepaymentApi.add_repayment, data: {
      'customId': state.customDTO?.id,
      'customType': state.customDTO?.customType,
      'repaymentDate':
          DateUtil.formatDate(state.date, format: DateFormats.y_mo_d),
      'settlementType': state.isSelect.value,
      'repaymentDetailRequest': state.customCreditDTO,
      'paymentRequest': [
        {
          'paymentMethodId': state.paymentMethodDTO?.id,
          'paymentAmount': inputAmount,
          'ordinal': 0
        }
      ],
      'totalAmount':
          (inputAmount ?? Decimal.zero) + (discountAmount ?? Decimal.zero),
      'discountAmount': discount,
      'remark': remark,
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        Toast.show('还款成功');
        Get.back(result: state.customType);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  Future<void> selectCustom() async {
    var result = await Get.toNamed(RouteConfig.chooseCustom, arguments: {
      'customType': state.customType,
      'isSelectCustom': true,
      'orderType': OrderType.REPAYMENT
    });
    if (result != null) {
      state.customDTO = result;
      update(['repayment_custom', 'repayment_bill_credit_amount']);
    }
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
          return child!;
        });
    if (picked != null) {
      state.date = picked;
      update(['bill_date']);
    }
  }

  Future<void> selectPaymentMethod() async {
    var result = await Get.toNamed(RouteConfig.paymentManage,
        arguments: {'isSelect': IsSelectType.TRUE});
    if (result != null) {
      state.paymentMethodDTO = result;
      update(['repayment_way']);
    }
  }

  Future<void> selectOrderBill() async {
    await Get.toNamed(RouteConfig.chooseRepaymentOrder,
        arguments: {'customDTO': state.customDTO})?.then((value) {
      List<CustomCreditDTO>? result = value as List<CustomCreditDTO>?;
      if ((result?.isNotEmpty ?? false) &&
          (state.isSelect == IsSelectType.TRUE)) {
        state.customCreditDTO = result;
        state.repaymentTotalAmount = result!
            .map((e) => e.repaymentAmount ?? Decimal.zero)
            .reduce((value, element) => value + element);
        state.repaymentAmount = state.repaymentTotalAmount;
        state.repaymentController.text =
            DecimalUtil.formatDecimalDefault(state.repaymentAmount);
        update([
          'repayment_credit_bill',
          'repayment_bill_btn',
          'repayment_discount_amount'
        ]);
      } else {
        update([
          'repayment_credit_bill',
          'repayment_bill_btn',
          'repayment_amount'
        ]);
      }
    });
  }

  judgeIsSelect(bool? value) {
    if (true == value) {
      state.isSelect = IsSelectType.TRUE;
    } else {
      state.isSelect = IsSelectType.FALSE;
      state.repaymentAmount = state.repaymentTotalAmount = Decimal.zero;
      state.customCreditDTO = null;
    }
    update([
      'is_selected',
      'repayment_credit_bill',
      'repayment_amount',
      'repayment_bill_btn'
    ]);
  }

  void repayBillGetBack() {
    String discount = state.discountController.text;
    String paymentAmount = state.repaymentController.text;
    if ((state.paymentMethodDTO != null) ||
        (state.isSelect == IsSelectType.TRUE) ||
        (paymentAmount.isNotEmpty) ||
        (discount.isNotEmpty) ||
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

  void repaymentAmountUpdate() {
    var discountAmountStr = state.discountController.text;
    var discountAmount = Decimal.tryParse(discountAmountStr);
    if (state.isSelect == IsSelectType.FALSE) {
      String repaymentAmountStr = state.repaymentController.text;
      var repaymentAmount =
          Decimal.tryParse(repaymentAmountStr) ?? Decimal.zero;
      if (null == discountAmount) {
        state.repaymentTotalAmount = repaymentAmount;
      } else {
        state.repaymentTotalAmount = discountAmount + repaymentAmount;
      }
    } else {
      if (null == discountAmount) {
        state.repaymentController.text =
            DecimalUtil.formatDecimalDefault(state.repaymentTotalAmount);
      } else {
        state.repaymentController.text = DecimalUtil.formatDecimalDefault(
            state.repaymentTotalAmount - discountAmount);
      }
      state.repaymentController.selection = TextSelection(
          baseOffset: 0,
          extentOffset: state.repaymentController.value.text.length);
    }
  }

  void discountAmountUpdate() {
    var repaymentAmountStr = state.repaymentController.text;
    var repaymentAmount = Decimal.tryParse(repaymentAmountStr);
    if (null == repaymentAmount) {
      return;
    }
    if (state.isSelect == IsSelectType.FALSE) {
      String discountAmountStr = state.discountController.text;
      state.repaymentTotalAmount = repaymentAmount +
          (Decimal.tryParse(discountAmountStr) ?? Decimal.zero);
    } else {
      state.discountController.text = DecimalUtil.formatDecimalNumber(
          state.repaymentTotalAmount - repaymentAmount);
    }
  }

  bool check() {
    if (StoreController.to.isCurrentLedgerOwner() ?? false) {
      return true;
    }
    if (DateUtil.currentIsBetween(
        state.salesLineDTO?.startTime, state.salesLineDTO?.endTime)) {
      return true;
    }
    return false;
  }
}
