import 'package:decimal/decimal.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/order_api.dart';
import 'package:ledger/config/api/payment_api.dart';
import 'package:ledger/config/api/product_api.dart';
import 'package:ledger/entity/draft/order_draft_detail_dto.dart';
import 'package:ledger/entity/payment/payment_method_dto.dart';
import 'package:ledger/entity/product/product_classify_list_dto.dart';
import 'package:ledger/entity/product/product_dto.dart';
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
import 'package:ledger/widget/loading.dart';

import 'pending_retail_bill_state.dart';

class PendingRetailBillController extends GetxController {
  final PendingRetailBillState state = PendingRetailBillState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if (arguments != null && arguments['draftId'] != null) {
      state.draftId = arguments['draftId'];
    }
    _queryProductClassifyList();
    initPaymentMethodList();
    pendingOrderNum();
    _queryPendingData();
  }

  _queryPendingData(){
    Http().network<OrderDraftDetailDTO>(Method.get, OrderApi.pending_order_detail,
        queryParameters: {
          'salesOrderDraftId': state.draftId,
        }).then((result) {
      if (result.success) {
        state.orderDraftDetailDTO = result.d;
        state.shoppingCarList =  result.d?.shoppingCarList??[];
        state.date = result.d?.orderDate ?? DateTime.now();
        state.customDTO  =  result.d?.customDTO;
        state.totalAmount = result.d?.totalAmount??Decimal.zero;
        update([
          'shopping_car_box',
          'retail_bill_sale_custom',
          'product_classify_list',
          'bill_date'
        ]);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  //拉取挂单 的数量
  void pendingOrderNum() {
    Http().network<int>(Method.post, OrderApi.pending_order_count).then((result) {
      if (result.success) {
        state.pendingOrderNum = result.d;
        update(['sale_bill_pending_order']);
      }
    });
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

  Future<void> pickerCustom() async {
    var result = await Get.toNamed(RouteConfig.customRecord, arguments: {
      'initialIndex': 0,
      'isSelectCustom': true,
      'orderType': OrderType.SALE
    });
    state.customDTO = result;
    update(['retail_bill_sale_custom']);
  }

  void searchShoppingCar(String value) {
    state.searchContent = value;
    onRefresh();
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
    return await Http().networkPage<ProductDTO>(
        Method.post, ProductApi.stockList,
        data: {
          'page': currentPage,
          'invalid': 0,
          'productClassify': state.selectType,
          'searchContent': state.searchContent,
        });
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
    Get.dialog(AlertDialog(
      title: null, // 设置标题为null，
      content: SingleChildScrollView(
        child: ProductUnitDialog(
          productDTO: productDTO,
          orderType: state.orderType,
          onClick: (result) {
            state.shoppingCarList?.add(result);
            update(['shopping_car_box']);
            return true;
          },
        ),
      ),
    ));
  }

  String getSalesChannel(int? channel) {
    for (var value in SalesChannel.values) {
      if (value.value == channel) {
        return value.desc;
      }
    }
    return '';
  }

  String judgeUnit(ProductDTO? productDTO) {
    if (null == productDTO) {
      return '-';
    }
    if (productDTO.unitDetailDTO?.unitType == UnitType.SINGLE.value) {
      return '${DecimalUtil.formatDecimalNumber(productDTO.unitDetailDTO?.stock)} ${productDTO.unitDetailDTO?.unitName}';
    } else {
      return '${DecimalUtil.formatDecimalNumber(productDTO.unitDetailDTO?.masterStock )} ${productDTO.unitDetailDTO?.masterUnitName} | ${productDTO.unitDetailDTO?.slaveStock ?? '0'} ${productDTO.unitDetailDTO?.slaveUnitName}';
    }
  }

  //挂单
  Future<bool> pendingOrder() async {
    if (state.shoppingCarList?.isEmpty??false) {
      Toast.show('请先选择商品');
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
        state.totalAmount  =Decimal.zero;
        state.date = DateTime.now();
        state.shoppingCarList =  [];
        state.customDTO = null;
        pendingOrderNum();
        update([ 'shopping_car_box',
          'retail_bill_sale_custom',
          'product_classify_list',
          'bill_date']);//需要更新下挂单列表按钮颜色和数字
        return true;
      } else {
        Toast.show(result.m.toString());
        return false;
      }
    });
  }

  void toShoppingCarList(){
    if (state.shoppingCarList?.isEmpty??false) {
      Toast.show('请先添加货物');
      return;
    }
    Get.toNamed(RouteConfig.shoppingCarList,arguments: {
      'shoppingCar':state.shoppingCarList,
      'totalAmount':state.totalAmount,
      'totalNumber':0});
  }

  String? getTotalAmount() {
    var totalAmount = Decimal.zero;
    state.shoppingCarList?.forEach((element) {
      totalAmount = totalAmount + element.unitDetailDTO!.totalAmount!;
    });
    state.totalAmount = totalAmount;
    return DecimalUtil.formatDecimalDefault(totalAmount);
  }

  //Dialog
  Future<void> showPaymentDialog(BuildContext context) async {
    if (state.shoppingCarList?.isEmpty??false) {
      Toast.show('请添加货物后再试');
      return;
    }
    if (state.orderType == OrderType.SALE_RETURN) {//判断方式可能需要改 TODO
      if (state.customDTO == null) {
        Toast.show('请选择客户' );
        return;
      }
    }
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
      'orderDraftId':state.orderDraftDetailDTO?.id,
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        Get.back();
        //Get.offNamed(RouteConfig.retailBill, arguments: {'orderType': state.orderType});
        return true;
      } else {
        Toast.show(result.m.toString());
        return false;
      }
    });
  }

  void saleBillGetBack() {
    if ((state.customDTO != null) ||
        (state.shoppingCarList?.isNotEmpty??false)
    ) {
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
                  state.shoppingCarList?.clear();
                  Get.until((route) {
                    return (route.settings.name == RouteConfig.sale) ||(route.settings.name == RouteConfig.pendingOrder)||
                        (route.settings.name == RouteConfig.main);
                  }
                  );
                }),
          ]));
    } else {
      Get.back();
    }
  }

}
