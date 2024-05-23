import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/repayment_api.dart';
import 'package:ledger/entity/repayment/custom_credit_dto.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/dialog/single_input_dialog.dart';
import 'choose_repayment_order_state.dart';

class ChooseRepaymentOrderController extends GetxController {
  final ChooseRepaymentOrderState state = ChooseRepaymentOrderState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['customDTO'] != null) {
      state.customDTO = arguments['customDTO'];
      update(['name']);
    }
    _queryData(state.currentPage);
  }

  bool? judgeIsSelect(int id) {
    for (var value in state.selected) {
      if (id == value.id) {
        return true;
      }
    }
    return false;
  }

  //checkBox选择的控制
  void addToSelected(bool? selected, CustomCreditDTO customCreditDTO) {
    if (true == selected) {
      var creditDTO = state.selected
          .firstWhereOrNull((element) => element.id == customCreditDTO.id);
      if (null == creditDTO) {
        customCreditDTO.repaymentAmount =
            customCreditDTO.repaymentAmount ?? customCreditDTO.creditAmount;
        state.selected.add(customCreditDTO);
      }
      state.totalAmount += (customCreditDTO.repaymentAmount ?? Decimal.zero);
    } else {
      var creditDTO = state.selected
          .firstWhereOrNull((element) => element.id == customCreditDTO.id);
      if (null != creditDTO) {
        state.selected.remove(creditDTO);
        state.totalAmount -= (creditDTO.repaymentAmount ?? Decimal.zero);
        creditDTO.repaymentAmount = null;
      }
      if (state.selectAll) {
        state.selectAll = false;
      }
    }
    update(['repayment_bill', 'choose_repayment_btn']);
  }

  void selectAll(bool? select) {
    if (true == select) {
      state.selectAll = true;
      if (state.items.isEmpty) {
        return;
      }
      state.totalAmount = Decimal.zero;
      state.selected.clear();
      for (var element in state.items) {
        element.repaymentAmount = element.creditAmount;
        state.selected.add(element);
        state.totalAmount += (element.creditAmount ?? Decimal.zero);
      }
    } else {
      state.selectAll = false;
      state.selected.clear();
      for (var element in state.items) {
        element.repaymentAmount = null;
      }
      state.totalAmount = Decimal.zero;
    }
    update(['repayment_bill', 'choose_repayment_btn']);
  }

  void editRepaymentAmount(CustomCreditDTO customCreditDTO) {
    var repaymentAmount = DecimalUtil.formatDecimalNumber(
        customCreditDTO.repaymentAmount ?? customCreditDTO.creditAmount);
    TextEditingController textEditingController =
        TextEditingController(text: (repaymentAmount));

    SingleInputDialog().singleInputDialog(
      title: '还款金额',
      controller: textEditingController,
      keyboardType: TextInputType.number,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: '还款金额不能为空！'),
        (value) {
          var repaymentAmount = Decimal.tryParse(value!);
          if (null == repaymentAmount) {
            return '请正确输入还款金额！';
          } else if (repaymentAmount <= Decimal.zero) {
            return '还款金额不能小于等于0';
          } else if (repaymentAmount >
              (customCreditDTO.creditAmount ?? Decimal.zero)) {
            return '本次还款不能大于待还金额';
          }
          return null;
        },
      ]),
      onTap: () {
        textEditingController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: textEditingController.value.text.length);
      },
      onOkPressed: (value) async {
        var repaymentAmount = Decimal.tryParse(value) ?? Decimal.zero;

        var creditDTO = state.selected
            .firstWhereOrNull((element) => element.id == customCreditDTO.id);
        if (null == creditDTO) {
          customCreditDTO.repaymentAmount = repaymentAmount;
          addToSelected(true, customCreditDTO);
        } else {
          state.totalAmount -=
              (customCreditDTO.repaymentAmount ?? Decimal.zero);
          customCreditDTO.repaymentAmount = repaymentAmount;
          state.totalAmount += repaymentAmount;
        }
        update(['repayment_bill', 'choose_repayment_btn']);
        return true;
      },
    );
  }

  _queryData(int currentPage) {
    Http().network<List<CustomCreditDTO>>(
        Method.post, RepaymentApi.choose_repayment_order_list,
        data: {
          'customId': state.customDTO?.id,
          'startDate': DateUtil.formatDefaultDate(state.startDate),
          'endDate': DateUtil.formatDefaultDate(state.endDate)
        }).then((result) {
      if (result.success) {
        var list = result.d;
        if (list?.isNotEmpty ?? false) {
          if (currentPage == 1) {
            state.items = list!;
          } else {
            state.items.addAll(result.d!);
          }
        }
        update(['repayment_bill']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  void toOrderDetail(CustomCreditDTO customCreditDTO) {
    switch (customCreditDTO.creditType) {
      case 0: //采购单
        Get.toNamed(RouteConfig.saleDetail, arguments: {
          'id': customCreditDTO.orderId,
          'orderType': OrderType.PURCHASE
        });
      case 1: //销售单
        Get.toNamed(RouteConfig.saleDetail, arguments: {
          'id': customCreditDTO.orderId,
          'orderType': OrderType.SALE
        });
      case 2: //销售退货单
        Get.toNamed(RouteConfig.saleDetail, arguments: {
          'id': customCreditDTO.orderId,
          'orderType': OrderType.SALE_RETURN
        });
      case 3: //采购退货单
        Get.toNamed(RouteConfig.saleDetail, arguments: {
          'id': customCreditDTO.orderId,
          'orderType': OrderType.PURCHASE_RETURN
        });
      case 5: //欠款单
        Toast.show('此单是录入欠款');
      case 10: //直接退款
        Get.toNamed(RouteConfig.saleDetail, arguments: {
          'id': customCreditDTO.orderId,
          'orderType': OrderType.REFUND
        });
      default:
        throw Exception('暂无详情');
    }
  }

  String creditType(int? type) {
    switch (type) {
      case 0:
        return '采购单';
      case 1:
        return '销售单';
      case 2:
        return '销售退货单';
      case 3:
        return '采购退货单';
      case 4:
        return '还款单';
      case 5:
        return '欠款单';
      case 9:
        return '直接入库';
      case 10:
        return '退款单';
      default:
        throw Exception('不支持的订单类型');
    }
  }

  void changeDate() {
    _queryData(state.currentPage);
  }

  Future<void> pickerSalesProductDateRange(BuildContext context) async {
    final date = await showRangePickerDialog(
      context: context,
      minDate: DateTime(2000, 1, 1),
      maxDate: DateTime.now().add(Duration(days: 30)),
      selectedRange: DateTimeRange(
        start: state.startDate,
        end: state.endDate,
      ),
    );
    if (date != null) {
      state.startDate = date.start;
      state.endDate = date.end;
      update(['date_range']);
      changeDate();
    }
  }
}
