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

import 'purchase_record_state.dart';

class PurchaseRecordController extends GetxController
    with GetSingleTickerProviderStateMixin
    implements DisposableInterface {
  final PurchaseRecordState state = PurchaseRecordState();

  late TabController tabController;

  Future<void> initState() async {
    var arguments = Get.arguments;
    if (arguments != null && arguments['index'] != null) {
      state.index = arguments['index'];
    }
    onRefresh();
    _queryLedgerUserList();
  }

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      var index = tabController.index;
      state.index = index;
      update(['purchase_record_add_bill']);
      clearCondition();
      onRefresh();
    });
    super.onInit();
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

  Future<BasePageEntity<OrderDTO>> _queryData(int currentPage) async {
    return await Http()
        .networkPage<OrderDTO>(Method.post, OrderApi.order_page, data: {
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

  int? orderTypes() {
    switch (state.index) {
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

  Future<void> onLoad() async {
    state.currentPage += 1;
    await _queryData(state.currentPage).then((result) {
      if (true == result.success) {
        state.list!.addAll(result.d!.result!);
        state.hasMore = result.d?.hasMore;
        update(['purchase_order_list']);
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
        update(['purchase_order_list']);
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishRefresh();
      }
    });
  }

  void toPurchaseDetail(OrderDTO? purchasePurchaseOrderDTO) {
    if (state.index == 2) {
      Get.toNamed(RouteConfig.addStockDetail, arguments: {
        'id': purchasePurchaseOrderDTO?.id,
      })?.then((value) {
        if (ProcessStatus.OK == value) {
          onRefresh();
        }
      });
    } else {
      Get.toNamed(RouteConfig.saleDetail, arguments: {
        'id': purchasePurchaseOrderDTO?.id,
        'orderType': orderType(purchasePurchaseOrderDTO?.orderType)
      })?.then((value) {
        if (ProcessStatus.OK == value) {
          onRefresh();
        }
      });
    }
  }

  String getOrderStatusDesc(int? orderStatus) {
    if (state.index == 0) {
      var list = OrderStateType.values;
      for (var value in list) {
        if (value.value == orderStatus) {
          return value.desc;
        }
      }
      return '';
    }
    return '';
  }

  String totalAmountOrNumber(OrderDTO purchasePurchaseOrderDTO) {
    if (state.index == 1) {
      return '￥- ${(purchasePurchaseOrderDTO.totalAmount ?? Decimal.zero) - (purchasePurchaseOrderDTO.discountAmount ?? Decimal.zero)}';
    } else if (state.index == 0) {
      return DecimalUtil.formatAmount(
          (purchasePurchaseOrderDTO.totalAmount ?? Decimal.zero) -
              (purchasePurchaseOrderDTO.discountAmount ?? Decimal.zero));
    } else {
      return '${purchasePurchaseOrderDTO.productNameList?.length}种';
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

  //选择业务员
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

  //筛选里选择业务员
  bool isEmployeeSelect(int? employeeId) {
    if (employeeId == null) {
      return false;
    }
    return (state.selectEmployeeIdList != null) &&
        state.selectEmployeeIdList!.contains(employeeId);
  }

  //收款状态
  bool checkOrderStatus(int? orderStatus) {
    return state.orderStatus == orderStatus;
  }

  //筛选里清空条件
  void clearCondition() {
    state.startDate = DateTime.now().subtract(Duration(days: 90));
    state.endDate = DateTime.now();
    state.selectEmployeeIdList = null;
    state.orderStatus = null;
    state.invalid = 0;
    update([
      'screen_btn',
      'switch',
      'purchase_order_status',
      'employee_button',
      'purchase_record_order_type',
      'date_range'
    ]);
  }

  //筛选里‘确定’
  void confirmCondition() {
    onRefresh();
    Get.back();
  }

  void toAddBill() {
    if (state.index == 0) {
      Get.toNamed(RouteConfig.saleBill,
              arguments: {'orderType': OrderType.PURCHASE})
          ?.then((value) => onRefresh());
    } else if (state.index == 1) {
      Get.toNamed(RouteConfig.saleBill,
              arguments: {'orderType': OrderType.PURCHASE_RETURN})
          ?.then((value) => onRefresh());
    } else {
      Get.toNamed(RouteConfig.saleBill,
              arguments: {'orderType': OrderType.ADD_STOCK})
          ?.then((value) => onRefresh());
    }
  }

  String toAddBillsName() {
    switch (state.index) {
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

  void searchPurchaseRecord(String value) {
    state.searchContent = value;
    onRefresh();
  }
}
