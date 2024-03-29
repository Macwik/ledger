import 'package:decimal/decimal.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/order_api.dart';
import 'package:ledger/config/api/payment_api.dart';
import 'package:ledger/config/api/product_api.dart';
import 'package:ledger/entity/payment/payment_method_dto.dart';
import 'package:ledger/entity/product/product_classify_list_dto.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/entity/unit/unit_detail_dto.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/sales_channel.dart';
import 'package:ledger/enum/unit_type.dart';
import 'package:ledger/http/base_page_entity.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/dialog_widget/payment_dialog/payment_dialog.dart';
import 'package:ledger/widget/dialog_widget/product_unit_dialog/product_unit_dialog.dart';
import 'package:ledger/widget/dialog_widget/refund_dialog/refund_dialog.dart';
import 'package:ledger/widget/loading.dart';

import 'retail_bill_state.dart';

class RetailBillController extends GetxController {
  final RetailBillState state = RetailBillState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['orderType'] != null) {
      state.orderType = arguments['orderType'];
    }
    initPaymentMethodList();
    pendingOrderNum();
    _queryProductClassifyList();
  }

  Future<void> onRefresh() async {
    state.currentPage = 1;
    _queryData(state.currentPage).then((result) {
      if (result.success) {
        state.productList = result.d?.result;
        state.hasMore = result.d?.hasMore;
        update(['product_classify_list']);
        state.refreshController.finishRefresh();
        state.refreshController.resetFooter();
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishRefresh();
      }
    });
  }

  Future<BasePageEntity<ProductDTO>> _queryData(int currentPage) async {
    return await Http()
        .networkPage<ProductDTO>(Method.post, ProductApi.stockList, data: {
      'page': currentPage,
      'invalid': 0,
      'productClassify': state.selectType,
      'searchContent': state.searchContent,
    });
  }

  void searchShoppingCar(String value) {
    state.searchContent = value;
    onRefresh();
  }

  void switchSelectType(int? id) {
    if (null == id) {
      return;
    }
    state.selectType = id;
    onRefresh();
  }

  toProductClassify() {
    Get.toNamed(RouteConfig.productTypeManage)
        ?.then((value) => _queryProductClassifyList());
  }

  //货物分类
  Future<void> _queryProductClassifyList() async {
    await Http()
        .network<ProductClassifyListDTO>(
            Method.post, ProductApi.product_classify_product_list)
        .then((result) {
      if (result.success) {
        state.productClassifyListDTO = result.d!;
        state.productList = result.d!.productList!;
        update(['product_classify_list']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  Future<void> onLoad() async {
    state.currentPage += 1;
    _queryData(state.currentPage).then((result) {
      if (result.success) {
        state.productList?.addAll(result.d!.result!);
        state.hasMore = result.d?.hasMore;
        update(['product_classify_list']);
        state.refreshController.finishLoad(state.hasMore ?? false
            ? IndicatorResult.success
            : IndicatorResult.noMore);
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishLoad(IndicatorResult.fail);
      }
    });
  }

  Future<void> addToShoppingCar(ProductDTO productDTO) async {
    if (state.orderType == OrderType.REFUND) {
      Get.dialog(AlertDialog(
        title: Text(
          productDTO.productName ?? '',
        ),
        content: SingleChildScrollView(
          child: RefundDialog(
            productDTO: productDTO,
            onClick: (result) {
              state.shoppingCarList.add(result);
              update(['shopping_car_box','product_classify_list']);
              return true;
            },
          ),
        ),
      ));
    } else {
      await Get.dialog(AlertDialog(
        title: null, // 设置标题为null，
        content: SingleChildScrollView(
          child: ProductUnitDialog(
            productDTO: productDTO,
            orderType: state.orderType,
            onClick: (result) {
              state.shoppingCarList.add(result);
              update(['shopping_car_box','product_classify_list']);
              return true;
            },
          ),
        ),
      ));
    }
  }

  Decimal getShoppingCarTotalNumber() {
    var shoppingCarList = state.shoppingCarList;
    if (shoppingCarList.isEmpty) {
      return Decimal.zero;
    }
    return shoppingCarList.fold(Decimal.zero, (previousValue, element) {
      if (element.unitDetailDTO?.unitType == UnitType.SINGLE.value) {
        return previousValue + (element.unitDetailDTO?.number ?? Decimal.zero);
      } else {
        return previousValue +
            (element.unitDetailDTO?.slaveNumber ?? Decimal.zero);
      }
    });
  }

  String getSalesChannel(int? channel) {
    for (var value in SalesChannel.values) {
      if (value.value == channel) {
        return value.desc;
      }
    }
    return '';
  }


  ///判断是否已添加购物车
  bool isInShoppingCar(int? productId){
    if(productId == null){
      return false;
    }
    return !state.shoppingCarList.map((e) => e.productId).toSet().contains(productId);
  }


  //选择日期
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

  String judgeUnit(ProductDTO? productDTO) {
    if (null == productDTO) {
      return '-';
    }
    if (productDTO.unitDetailDTO?.unitType == UnitType.SINGLE.value) {
      return '${DecimalUtil.formatDecimalNumber(productDTO.unitDetailDTO?.stock)} ${productDTO.unitDetailDTO?.unitName}';
    } else {
      return '${DecimalUtil.formatDecimalNumber(productDTO.unitDetailDTO?.masterStock)} ${productDTO.unitDetailDTO?.masterUnitName} | ${productDTO.unitDetailDTO?.slaveStock ?? '0'} ${productDTO.unitDetailDTO?.slaveUnitName}';
    }
  }

  void toShoppingCarList(BuildContext context) {
      if (state.shoppingCarList.isEmpty) {
        Toast.show('请先添加货物');
        return;
      }
      Get.toNamed(RouteConfig.shoppingCarList, arguments: {
        'shoppingCar': state.shoppingCarList,
      })?.then((value) {
        state.shoppingCarList = value;
        update(['shopping_car_box','product_classify_list']);
      });
  }


  String? getNumber(UnitDetailDTO unitDetailDTO) {
    var unitType = unitDetailDTO.unitType;
    if (UnitType.SINGLE.value == unitType) {
      return '${unitDetailDTO.number} ${unitDetailDTO.unitName}';
    } else {
      if (unitDetailDTO.selectMasterUnit ?? true) {
        if (UnitType.MULTI_WEIGHT.value == unitType) {
          return '${unitDetailDTO.slaveNumber} ${unitDetailDTO.slaveUnitName}';
        }
        return '${unitDetailDTO.masterNumber} ${unitDetailDTO.masterUnitName}';
      } else {
        return '${unitDetailDTO.slaveNumber} ${unitDetailDTO.slaveUnitName}';
      }
    }
  }

  String? getPrice(UnitDetailDTO unitDetailDTO) {
    var unitType = unitDetailDTO.unitType;
    if (UnitType.SINGLE.value == unitType) {
      if (unitDetailDTO.price == null) {
        return '';
      } else {
        return '${unitDetailDTO.price}元/${unitDetailDTO.unitName}';
      }
    } else {
      if (unitDetailDTO.selectMasterUnit ?? true) {
        if (unitDetailDTO.masterPrice == null) {
          return '';
        } else {
          return '${unitDetailDTO.masterPrice}元/${unitDetailDTO.masterUnitName}';
        }
      } else {
        if (unitDetailDTO.slavePrice == null) {
          return '';
        } else {
          return '${unitDetailDTO.slavePrice}元/${unitDetailDTO.slaveUnitName}';
        }
      }
    }
  }

  String? getWeight(UnitDetailDTO unitDetailDTO) {
    var unitType = unitDetailDTO.unitType;
    if (UnitType.MULTI_WEIGHT.value == unitType) {
      if (unitDetailDTO.selectMasterUnit ?? true) {
        return '${unitDetailDTO.masterNumber} ${unitDetailDTO.masterUnitName}';
      }
    }
    return '-';
  }

  String? getTotalAmount() {
    var totalAmount = Decimal.zero;
    for (var element in state.shoppingCarList) {
      totalAmount = totalAmount + element.unitDetailDTO!.totalAmount!;
    }
    state.totalAmount = totalAmount;
    return DecimalUtil.formatDecimalDefault(totalAmount);
  }

  Future<void> pickerCustom() async {
    var result = await Get.toNamed(RouteConfig.customRecord, arguments: {
      'initialIndex': 0,
      'isSelectCustom': true,
      'orderType': state.orderType
    });
    state.customDTO = result;
    update(['retail_bill_sale_custom']);
  }

  //挂单
  Future<bool> pendingOrder() async {
    if (state.shoppingCarList.isEmpty) {
      Toast.show('开单商品不能为空');
      return Future(() => false);
    }
    Loading.showDuration();
    return await Http().network(Method.post, OrderApi.add_pending_order, data: {
      'customId': state.customDTO?.id,
      'orderProductRequest': state.shoppingCarList,
      'orderDate': DateUtil.formatDefaultDate(state.date),
      'orderType': state.orderType.value,
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        Toast.show('挂单成功');
        state.totalAmount = Decimal.zero;
        state.date = DateTime.now();
        state.shoppingCarList = [];
        state.customDTO = null;
        pendingOrderNum();
        update([
          'retail_bill_sale_custom',
          'bill_date',
          'shopping_car_box',
          'product_classify_list',
          'sale_bill_pending_order'
        ]); //需要更新下挂单列表按钮颜色和数字
        return true;
      } else {
        Toast.show(result.m.toString());
        return false;
      }
    });
  }

  //拉取挂单 的数量
  void pendingOrderNum() {
    Http()
        .network<int>(Method.post, OrderApi.pending_order_count)
        .then((result) {
      if (result.success) {
        state.pendingOrderNum = result.d;
        update(['sale_bill_pending_order']);
      }
    });
  }

//拉支付方式
  void initPaymentMethodList() {
    Http()
        .network<List<PaymentMethodDTO>>(
            Method.get, PaymentApi.LEDGER_PAYMENT_METHOD_LIST)
        .then((result) {
      if (result.success) {
        state.paymentMethods = result.d!;
      } else {
        Toast.show('网络异常');
      }
    });
  }

  //选择客户
  String customName() {
    if (state.orderType == OrderType.SALE) {
      return state.customDTO?.customName ?? '选择客户';
    } else {
      return state.customDTO?.customName ?? '请选择';
    }
  }

  //Dialog
  Future<void> showPaymentDialog() async {
    if (state.shoppingCarList.isEmpty) {
      Toast.show('请添加货物后再试');
      return;
    }
    if ((state.orderType == OrderType.SALE_RETURN) ||
        (state.orderType == OrderType.REFUND)) {
      if (state.customDTO == null) {
        Toast.show('请选择客户');
        return;
      }
    }
    await Get.bottomSheet(
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
              if (state.orderType == OrderType.REFUND) {
                return await saveRefundOrder();
              } else {
                return await saveOrder();
              }
            }),
        backgroundColor: Colors.white);
  }

  Future<bool> saveRefundOrder() async {
    Loading.showDuration();
    return await Http()
        .network(Method.post, OrderApi.add_refund_order_page, data: {
      'customId': state.customDTO?.id,
      'creditAmount': state.orderPayDialogResult?.creditAmount,
      'discountAmount': state.orderPayDialogResult?.discountAmount,
      'orderProductRequest': state.shoppingCarList,
      'orderPaymentRequest': state.orderPayDialogResult?.orderPaymentRequest,
      'remark': state.orderPayDialogResult?.remark,
      'orderDate': DateUtil.formatDefaultDate(state.date),
      'orderType': OrderType.REFUND.value,
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

  Future<bool> saveOrder() async {
    Loading.showDuration();
    return await Http().network(Method.post, OrderApi.add_order_page, data: {
      'customId': state.customDTO?.id,
      'creditAmount': state.orderPayDialogResult?.creditAmount,
      'discountAmount': state.orderPayDialogResult?.discountAmount,
      'orderProductRequest': state.shoppingCarList,
      'orderPaymentRequest': state.orderPayDialogResult?.orderPaymentRequest,
      'remark': state.orderPayDialogResult?.remark,
      'orderDate': DateUtil.formatDefaultDate(state.date),
      'orderType': state.orderType.value,
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        Get.back();

        ///TODO 开单详情的弹框
        Toast.showSuccess('开单成功');
        return true;
      } else {
        Toast.show(result.m.toString());
        return false;
      }
    });
  }

  Future<void> saleBillGetBack() async {
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
                    return (route.settings.name == RouteConfig.saleRecord) ||
                        (route.settings.name == RouteConfig.main);
                  });
                }),
          ]));
    } else {
      Get.back();
    }
  }
}
