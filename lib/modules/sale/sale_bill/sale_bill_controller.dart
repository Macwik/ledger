import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/ledger_api.dart';
import 'package:ledger/config/api/order_api.dart';
import 'package:ledger/config/api/payment_api.dart';
import 'package:ledger/entity/payment/payment_method_dto.dart';
import 'package:ledger/entity/product/product_shopping_car_dto.dart';
import 'package:ledger/entity/unit/unit_detail_dto.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/page_to_type.dart';
import 'package:ledger/enum/unit_type.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/store/store_controller.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/widget/dialog_widget/payment_dialog/payment_dialog.dart';
import 'package:uuid/uuid.dart';

import 'sale_bill_state.dart';

class SaleBillController extends GetxController {
  final SaleBillState state = SaleBillState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if (arguments != null && arguments['orderType'] != null) {
      state.orderType = arguments['orderType'];
    }
    queryLedgerName();
    initPaymentMethodList();
    generateBatchNumber(((state.orderType == OrderType.PURCHASE)||(state.orderType == OrderType.ADD_STOCK))? false : true);
  }

  //拉取付款方式
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
      'initialIndex':  1,
      'isSelectCustom': true,
      'orderType': state.orderType
    });
    state.customDTO = result;
    update(['bill_custom']);
  }

//Dialog
  void showPaymentDialog(BuildContext context) {
    if (state.shoppingCarList.isEmpty) {
      Toast.show('请添加货物后再试');
      return;
    } else if (((state.orderType ==OrderType.PURCHASE)||(state.orderType ==OrderType.ADD_STOCK))
         && (state.textEditingController.text.isEmpty)) {
      Toast.show('请添填写批号后再试');
      return;
    }
    if (state.orderType == OrderType.PURCHASE_RETURN) {
      if (state.customDTO == null) {
        Toast.show('请选择供应商');
        return;
      }
    }
    if(state.orderType ==OrderType.ADD_STOCK){
      //执行保存入库命令代码
      Toast.show('入库成功'); //ToDo 需要加入库后推数据，及页面跳转
    }else{
      Get.bottomSheet(
          isScrollControlled: true,
          PaymentDialog(
              paymentMethods: state.paymentMethods!,
              customDTO: state.customDTO,
              orderType: state.orderType,
              totalAmount: state.totalAmount,
              onClick: (result) async {
                state.orderPayDialogResult = result;
                if (null != result?.customDTO) {
                  state.customDTO = result?.customDTO;
                }
                return await saveOrder();
              }),
          backgroundColor: Colors.white);
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
            update(['sale_bill_product_list', 'sale_bill_btn']);
            Toast.show('删除成功');
          }),
    );
  }

  Future<void> addShoppingCar() async {
    var result = await Get.toNamed(RouteConfig.shoppingCar,
        arguments: {'pageType': PageToType.BILL, 'orderType': state.orderType});
        addToShoppingCar(result);
  }

  Future<bool> saveOrder() async {
    String batchNumber = state.textEditingController.text;
    Loading.showDuration();
    return await Http().network(Method.post, OrderApi.add_order_page, data: {
      'customId': state.customDTO?.id,
      'creditAmount': state.orderPayDialogResult?.creditAmount,
      'discountAmount': state.orderPayDialogResult?.discountAmount,
      'batchNo': batchNumber,
      'orderProductRequest': state.shoppingCarList,
      'orderPaymentRequest': state.orderPayDialogResult?.orderPaymentRequest,
      'remark': state.orderPayDialogResult?.remark,
      'orderDate': DateUtil.formatDefaultDate(state.date),
      'orderType': state.orderType.value,
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        Get.offNamed(RouteConfig.retailBill, arguments: {'orderType': state.orderType});
        return true;
      } else {
        Toast.show(result.m.toString());
        return false;
      }
    });
  }

  void generateBatchNumber(bool? check) {
    state.checked = check ?? state.checked;
    if (check ?? false) {
      var dateStr = DateUtil.formatDate(DateTime.now(), format: DateFormats.YY_MM_DD_HH);
      var suffix = Uuid().v4().substring(0, 3);
      state.textEditingController.text = '$dateStr$suffix';
    } else {
      state.textEditingController.text = '';
    }
    update(['bill_checkbox']);
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
        'sale_bill_product_list',
        'sale_bill_product_title',
        'sale_bill_btn'
      ]);
    }
  }

  void saleBillGetBack() {
    if ((state.customDTO != null) ||
        (state.shoppingCarList.isNotEmpty)) {
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
                  state.shoppingCarList.clear();
                  Get.until((route) {
                    return (route.settings.name == RouteConfig.purchase) ||
                        (route.settings.name == RouteConfig.stock)||
                        (route.settings.name == RouteConfig.main);
                  }
                 );
                }),
          ]));
    } else {
      Get.back();
    }
  }

  String totalAmount() {
    if (state.orderType == OrderType.PURCHASE_RETURN) {
      return '应收：';
    } else {
      return '应付：';
    }
  }

  String? getNumber(UnitDetailDTO unitDetailDTO) {
    var unitType = unitDetailDTO.unitType;
    if (UnitType.SINGLE.value == unitType) {
      return '${unitDetailDTO.number} ${unitDetailDTO.unitName}';
    } else {
      if (unitDetailDTO.selectMasterUnit ?? true) {
        return '${unitDetailDTO.masterNumber} ${unitDetailDTO.masterUnitName}';
      } else {
        return '${unitDetailDTO.slaveNumber} ${unitDetailDTO.slaveUnitName}';
      }
    }
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

  String? getAddStockNum(UnitDetailDTO unitDetailDTO) {
    var unitType = unitDetailDTO.unitType;
    if (UnitType.SINGLE.value == unitType) {
      return '${DecimalUtil.formatDecimalNumber(unitDetailDTO.stock)} ${unitDetailDTO.unitName}';
    } else {
      if (unitDetailDTO.selectMasterUnit ?? true) {
        return '${DecimalUtil.formatDecimalNumber(unitDetailDTO.masterStock)} ${unitDetailDTO.masterUnitName}';
      } else {
        return '${DecimalUtil.formatDecimalNumber(unitDetailDTO.slaveStock)} ${unitDetailDTO.slaveUnitName}';
      }
    }
  }

  String saleBillTitle() {
    if ((state.orderType == OrderType.ADD_STOCK)) {
      return '添加库存';
    } else if (state.orderType == OrderType.PURCHASE) {
      return '采购开单';
    } else if (state.orderType == OrderType.SALE_RETURN) {
      return '销售退货开单';
    } else {
      return '采购退货开单';
    }
  }

  String customName() {
    if (state.orderType == OrderType.PURCHASE) {
      return state.customDTO?.customName ?? '默认供应商';
    } else {
      return state.customDTO?.customName ?? '请选择';
    }
  }

  void explainBatchNumber() {
    Get.dialog(AlertDialog(
        title: Text('批次号'),
        content: Text('批次号是采购单的识别号',
            style: TextStyle(
              color: Colours.text_333,
              fontSize: 32.sp,
            )),
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
