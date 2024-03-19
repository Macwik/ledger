import 'package:decimal/decimal.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/ledger_api.dart';
import 'package:ledger/config/api/order_api.dart';
import 'package:ledger/entity/order/order_dto.dart';
import 'package:ledger/entity/user/user_base_dto.dart';
import 'package:ledger/enum/order_state_type.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/http/base_page_entity.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/toast_util.dart';

import 'sale_record_state.dart';

class SaleRecordController extends GetxController with GetSingleTickerProviderStateMixin implements DisposableInterface{
  final SaleRecordState state = SaleRecordState();

  late TabController tabController;

  Future<void> initState() async {
    var arguments = Get.arguments;
    if (arguments != null && arguments['orderType'] != null) {
      state.orderType = arguments['orderType'];
    }
    if (arguments != null && arguments['index'] != null) {
      state.index =arguments['index'];
    }
    onRefresh();
  //  update(['sale_record_tab']);
    _queryLedgerUserList();
  }


  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      var index = tabController.index;
      state.index = index;
      update(['sale_record_add_bill']);
      clearCondition();
      checkOrderType();
      onRefresh();
    });
    super.onInit();
  }

  void checkOrderType(){
    switch (state.index) {
      case 0:
         state.orderType = OrderType.PURCHASE;
      case 1:
        state.orderType = OrderType.PURCHASE_RETURN;
      case 2:
        state.orderType = OrderType.ADD_STOCK;
      default:
        throw Exception('Unsupported ChangePasswordType');
    }
  }

  // @override
  // void onClose() {
  //   tabController.dispose(); // 清理操作
  //   super.onClose();
  // }

  Future<BasePageEntity<OrderDTO>> _queryData(int currentPage) async {
    return await Http().networkPage<OrderDTO>(Method.post, OrderApi.order_page, data: {
      'page': currentPage,
      'orderTypeList': [orderTypes()],
      'userIdList': state.selectEmployeeIdList,
      'orderStatus': state.orderStatus,
      'invalid': state.invalid,
      'searchContent': state.searchContent,
      'startDate': DateUtil.formatDefaultDate(state.startDate),
      'endDate': DateUtil.formatDefaultDate(state.endDate),
    });
  }

 int? orderTypes(){
    if (state.orderType == OrderType.SALE) {
      switch(state.index){
        case 0:
      return OrderType.SALE.value;
        case 1:
          return OrderType.SALE_RETURN.value;
        case 2:
          return OrderType.REFUND.value;
        default:
          throw Exception('无此项');
      }
    }else{
      switch(state.index){
        case 0:
          return OrderType.PURCHASE.value;
        case 1:
          return OrderType.PURCHASE_RETURN.value;
        case 2:
          return OrderType.ADD_STOCK.value;
        default:
          throw Exception('无此项');
      }
    }
  }

  //收款状态
  bool checkOrderStatus(int? orderStatus) {
    return state.orderStatus == orderStatus;
  }

  //单据类型
  // bool checkOrderTypeAll() {
  //   return state.typeList.length == 2;
  // }

  String getOrderStatusDesc(int? orderStatus) {
    if((state.orderType == OrderType.SALE) ||(state.orderType == OrderType.PURCHASE)){
      var list = OrderStateType.values;
      for (var value in list) {
        if (value.value == orderStatus) {
          return value.desc;
        }
      }return '';
    }return '';
  }

  Future<void> onLoad() async {
    state.currentPage += 1;
    await _queryData(state.currentPage).then((result) {
      if (true == result.success) {
        state.list!.addAll(result.d!.result!);
        state.hasMore = result.d?.hasMore;
        update(['sales_order_list']);
        state.refreshController.finishLoad(state.hasMore ?? false
            ? IndicatorResult.success
            : IndicatorResult.noMore);
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishLoad(IndicatorResult.fail);
      }
    });
  }

  Future<void> onRefresh() async {
    state.currentPage = 1;
    await _queryData(state.currentPage).then((result) {
      if (true == result.success) {
        state.list = result.d?.result;
        state.hasMore = result.d?.hasMore;
        state.refreshController.finishRefresh();
        state.refreshController.resetFooter();
        update(['sales_order_list']);
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishRefresh();
      }
    });
  }

  //筛选里拉取业务员信息
  Future<void> _queryLedgerUserList() async {
    final result = await Http()
        .network<List<UserBaseDTO>>(Method.get, LedgerApi.ledger_user_list);
    if (result.success) {
      state.employeeList = result.d;
      update(['employee_button']);
    } else {
      Toast.show(result.m.toString());
    }
  }

  //筛选里选择业务员
  bool isEmployeeSelect(int? employeeId) {
    if (employeeId == null) {
      return false;
    }
    return (state.selectEmployeeIdList != null) &&
        state.selectEmployeeIdList!.contains(employeeId);
  }

  //筛选里清空条件
  void clearCondition() {
    state.startDate = DateTime.now().subtract(Duration(days: 7));
    state.endDate = DateTime.now();
    state.selectEmployeeIdList = null;
    state.orderStatus = null;
    state.invalid = 0;
    update([
      'screen_btn',
      'switch',
      'sale_order_status',
      'employee_button',
      'sale_record_order_type',
      'date_range'
    ]);
  }

  //筛选里‘确定’
  void confirmCondition() {
    onRefresh();
    Get.back();
  }

  void selectEmployee(int? id) {
    if ((state.selectEmployeeIdList != null) &&
        state.selectEmployeeIdList!.contains(id)) {
      state.selectEmployeeIdList!.remove(id);
      if (state.selectEmployeeIdList!.isEmpty) {
        state.selectEmployeeIdList = null;
        update(['employee_button']);
      }
    } else {
      state.selectEmployeeIdList = state.selectEmployeeIdList ?? [];
      state.selectEmployeeIdList!.add(id!);
    }
    update(['employee_button']);
  }

  void searchSalesRecord(String value) {
    state.searchContent = value;
    onRefresh();
  }

  void toSalesDetail(OrderDTO? salePurchaseOrderDTO) {
    if(state.orderType == OrderType.ADD_STOCK){
      Get.toNamed(RouteConfig.addStockDetail, arguments: {
        'id': salePurchaseOrderDTO?.id,
      })?.then((value) {
        if (ProcessStatus.OK == value) {
          onRefresh();
        }
      });
    }else{
      Get.toNamed(RouteConfig.saleDetail, arguments: {
        'id': salePurchaseOrderDTO?.id,
        'orderType': orderType(salePurchaseOrderDTO?.orderType)
      })?.then((value) {
        if (ProcessStatus.OK == value) {
          onRefresh();
        }
      });
    }

  }

  OrderType orderType(int? orderType) {
    switch (orderType) {
      case 0:
        return OrderType.PURCHASE;
      case 1:
        return OrderType.SALE;
      case 2:
        return OrderType.SALE_RETURN;
      case 3:
        return OrderType.PURCHASE_RETURN;
      case 9:
        return OrderType.ADD_STOCK;
      case 10:
        return OrderType.REFUND;
      default:
        throw Exception('销售记录页无此OrderType');
    }
  }

  String totalAmount(OrderDTO salePurchaseOrderDTO) {
    if ((salePurchaseOrderDTO.orderType == OrderType.SALE_RETURN.value) ||
        (salePurchaseOrderDTO.orderType == OrderType.PURCHASE_RETURN.value)) {
      return '￥- ${(salePurchaseOrderDTO.totalAmount ?? Decimal.zero) - (salePurchaseOrderDTO.discountAmount ?? Decimal.zero)}';
    } else {
      return DecimalUtil.formatAmount(
          (salePurchaseOrderDTO.totalAmount ?? Decimal.zero) -
              (salePurchaseOrderDTO.discountAmount ?? Decimal.zero));
    }
  }

  void toAddBill() {
    if((state.orderType == OrderType.PURCHASE)||(state.orderType == OrderType.PURCHASE_RETURN)||(state.orderType == OrderType.ADD_STOCK)){
      if(state.index == 0){
        Get.toNamed(RouteConfig.saleBill, arguments: {'orderType': OrderType.PURCHASE});
      }else if(state.index == 1){
        Get.toNamed(RouteConfig.saleBill, arguments: {'orderType': OrderType.PURCHASE_RETURN});}
      else{
        Get.toNamed(RouteConfig.saleBill, arguments: {'orderType': OrderType.ADD_STOCK});
      }
    }else{
        if(state.index == 0){
          Get.toNamed(RouteConfig.retailBill, arguments: {'orderType': OrderType.SALE});
        }else if(state.index == 1){
          Get.toNamed(RouteConfig.retailBill, arguments: {'orderType': OrderType.SALE_RETURN});
        }else{
          Get.toNamed(RouteConfig.retailBill, arguments: {'orderType': OrderType.REFUND});
        }
    }
  }

  String toAddBillsName(){
    if(state.orderType==OrderType.SALE){
      switch(state.index){
        case 0:
          return '+ 销售';
        case 1:
          return '+ 退货';
        case 2:
          return '+ 退款';
        default:
          throw Exception('此项不存在');
      }
    }else{
      switch(state.index){
        case 0:
          return '+ 采购';
        case 1:
          return '+ 退货';
        case 2:
          return '+ 入库';
        default:
          throw Exception('此项不存在');
      }
    }
  }
}

//enum SalesRecordSelectType { ALL, COMMON, RETURN }
