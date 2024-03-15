import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/ledger_api.dart';
import 'package:ledger/config/api/order_api.dart';
import 'package:ledger/config/api/payment_api.dart';
import 'package:ledger/entity/draft/order_draft_detail_dto.dart';
import 'package:ledger/entity/payment/payment_method_dto.dart';
import 'package:ledger/entity/product/product_shopping_car_dto.dart';
import 'package:ledger/entity/unit/unit_detail_dto.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/page_to_type.dart';
import 'package:ledger/enum/unit_type.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/store/store_controller.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/dialog_widget/payment_dialog/payment_dialog.dart';
import 'package:ledger/widget/loading.dart';
import 'package:ledger/widget/warning.dart';

import 'pending_sale_bill_state.dart';

class PendingSaleBillController extends GetxController {
  final PendingSaleBillState state = PendingSaleBillState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if (arguments != null && arguments['draftId'] != null) {
      state.draftId = arguments['draftId'];
    }
    initPaymentMethodList();
    queryLedgerName();
    pendingOrderNum();
    _queryData();
  }

  _queryData(){
    Http().network<OrderDraftDetailDTO>(Method.get, OrderApi.pending_order_detail,
        queryParameters: {
          'salesOrderDraftId': state.draftId,
        }).then((result) {
      if (result.success) {
        state.orderDraftDetailDTO = result.d;
        state.shoppingCarList =  result.d?.shoppingCarList??[];
        state.date = result.d?.orderDate ?? DateTime.now();
        state.customDTO  =  result.d?.customDTO;
        state.remarkTextEditingController.text =  result.d?.remark ??'';
        state.totalAmount = result.d?.totalAmount??Decimal.zero;
        state.visible = true;
        update([
          'pending_sale_bill_product_list',
          'sale_bill_product_title',
          'bill_custom',
          'sale_bill_btn',
          'bill_remark',
          'bill_date'
        ]);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  Future<void> pickerDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
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

  Future<void> pickerCustom() async {
    var result = await Get.toNamed(RouteConfig.customRecord, arguments: {
      'initialIndex':  0,
      'isSelectCustom': true,
      'orderType': OrderType.SALE
    });
    state.customDTO = result;
    update(['bill_custom']);
  }

  Future<void> addShoppingCar() async {
    var result = await Get.toNamed(RouteConfig.shoppingCar,
        arguments: {'pageType': PageToType.BILL, 'orderType':  OrderType.SALE});
    addToShoppingCar(result);
  }

  void addToShoppingCar(List<ProductShoppingCarDTO>? productList) {
    if ((null != productList) && productList.isNotEmpty) {
      state.shoppingCarList.addAll(productList);
      var totalAmount = state.shoppingCarList
          .map((e) => (e.unitDetailDTO?.totalAmount ?? Decimal.zero))
          .reduce((value, element) => value + element);
      state.totalAmount = totalAmount;
      if (state.shoppingCarList.isNotEmpty) {
        state.visible = true;
      } else {
        state.visible = false;
      }
      update([
        'pending_sale_bill_product_list',
        'sale_bill_product_title',
        'sale_bill_btn'
      ]);
    }
  }

  void toDeleteOrder(ProductShoppingCarDTO productShoppingCarDTO) {
    Get.dialog(
      Warning(
          cancel: '取消',
          confirm: '确定',
          content: '确认删除此条吗？',
          onCancel: () {},
          onConfirm: () {
            state.shoppingCarList.remove(productShoppingCarDTO);
            if (state.shoppingCarList.isEmpty) {
              state.totalAmount = Decimal.zero;
            } else {
              state.totalAmount = state.shoppingCarList
                  .map((e) => (e.unitDetailDTO?.totalAmount ?? Decimal.zero))
                  .reduce((value, element) => value + element);
            }
            update(['pending_sale_bill_product_list', 'sale_bill_btn']);
            Toast.show('删除成功');
          }),
    );
  }

  Future<bool> pendingOrder() async {
    if (state.shoppingCarList.isEmpty) {
      Toast.show('开单商品不能为空');
      return Future(() => false);
    }
    Loading.showDuration();
    return await Http().network(Method.post, OrderApi.add_pending_order, data: {
      'customId': state.customDTO?.id,
      'orderProductRequest': state.shoppingCarList,
      'remark': state.remarkTextEditingController.text,
      'orderDate': DateUtil.formatDefaultDate(state.date),
      'orderType':OrderType.SALE.value,
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        Toast.show('挂单成功');
        state.totalAmount  =Decimal.zero;
        state.date = DateTime.now();
        state.shoppingCarList =  [];
        state.customDTO = null;
        state.remarkTextEditingController.text = '';
        state.visible = false;
        pendingOrderNum();
        update(['bill_date','bill_custom',
          'sale_bill_product_title','pending_sale_bill_product_list','sale_bill_btn'
        ]);//需要更新下挂单列表按钮颜色和数字
        return true;
      } else {
        Toast.show(result.m.toString());
        return false;
      }
    });
  }

  void showPaymentDialog(BuildContext context) {
    if (state.shoppingCarList.isEmpty) {
      Toast.show('请添加货物后再试');
      return;
    }
    Get.bottomSheet(
        isScrollControlled: true,
        PaymentDialog(
            paymentMethods: state.paymentMethods!,
            customDTO: state.customDTO,
            orderType: OrderType.SALE,
            totalAmount: state.totalAmount,
            onClick: (result) async {
              state.orderPayDialogResult = result;
              if (null != result?.customDTO) {
                state.customDTO = result?.customDTO;
              }
              return await saveOrder();
            }),
        // ),
        backgroundColor: Colors.white);
  }

  void initPaymentMethodList() {
    Http().network<List<PaymentMethodDTO>>(Method.get, PaymentApi.LEDGER_PAYMENT_METHOD_LIST)
        .then((result) {
      if (result.success) {
        state.paymentMethods = result.d!;
      } else {
        Toast.show('网络异常');
      }
    });
  }

  void queryLedgerName() {
    var activeLedgerId = StoreController.to.getActiveLedgerId();
    Http().network<String>(Method.get, LedgerApi.ledger_name,
        queryParameters: {'ledgerId': activeLedgerId}).then((result) {
      if (result.success) {
        state.ledgerName = result.d;
        update([
          'bill_title',
        ]);
      }
    });
  }

  Future<bool> saveOrder() async {
    String? remark = state.formKey.currentState?.fields['remark']?.value;
    Loading.showDuration();
    return await Http().network(Method.post, OrderApi.add_order_page, data: {
      'customId': state.customDTO?.id,
      'creditAmount': state.orderPayDialogResult?.creditAmount,
      'discountAmount': state.orderPayDialogResult?.discountAmount,
      'orderProductRequest': state.shoppingCarList,
      'orderPaymentRequest': state.orderPayDialogResult?.orderPaymentRequest,
      'remark': remark,
      'orderDate': DateUtil.formatDefaultDate(state.date),
      'orderType': OrderType.SALE.value,
    'orderDraftId':state.orderDraftDetailDTO?.id,
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        Get.back();
        return true;
      } else {
        Toast.show(result.m.toString());
        return false;
      }
    });
  }

  String? getPrice(UnitDetailDTO unitDetailDTO) {
    var unitType = unitDetailDTO.unitType;
    if (UnitType.SINGLE.value == unitType) {
      return '${unitDetailDTO.price}元/${unitDetailDTO.unitName}*${DecimalUtil.formatDecimalNumber(unitDetailDTO.number)} ${unitDetailDTO.unitName}';
    } else {
      if (unitDetailDTO.selectMasterUnit ?? true) {
        return '${unitDetailDTO.masterPrice}元/${unitDetailDTO.masterUnitName}*${DecimalUtil.formatDecimalNumber(unitDetailDTO.masterNumber)} ${unitDetailDTO.masterUnitName}';
      } else {
        return '${unitDetailDTO.slavePrice}元/${unitDetailDTO.slaveUnitName}*${DecimalUtil.formatDecimalNumber(unitDetailDTO.slaveNumber)} ${unitDetailDTO.slaveUnitName}';
      }
    }
  }

  //拉取挂单 的数量
  void pendingOrderNum() {
    Http().network<int>(Method.post, OrderApi.pending_order_count).then((result) {
      if (result.success) {
        state.pendingOrderNum = result.d;
        update(['pending_order_count']);
      }
    });
  }
}
