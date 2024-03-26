import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/custom_api.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/entity/statistics/sales_order_accounts_dto.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/http/base_page_entity.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/toast_util.dart';

import 'supplier_detail_state.dart';

class SupplierDetailController extends GetxController {
  final SupplierDetailState state = SupplierDetailState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['customDTO'] != null) {
      state.custom = arguments['customDTO'];
      update(['supplier_name']);
    }
    if ((arguments != null) && arguments['customType'] != null) {
      state.customType = arguments['customType'];
    }
    _queryData();
    onRefresh();
  }

  _queryData() {
    Http().network<CustomDTO>(Method.post, CustomApi.supplier_detail_title,
        queryParameters: {
          'id': state.custom?.id,
        }).then((result) {
      if (result.success) {
        state.customDTO = result.d;
        update([
          'supplier_name',
          'supplier_btn',
          'supplier_detail_sum',
          'custom_record'
        ]);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  Future<BasePageEntity<SalesOrderAccountsDTO>> _queryDataDetail(
      int currentPage) async {
    return await Http().networkPage<SalesOrderAccountsDTO>(
        Method.post, CustomApi.supplier_detail,
        data: {
          'page': currentPage,
          'customId': state.custom?.id,
          'orderType': state.orderType,
          'startDate': DateUtil.formatDefaultDate(state.startDate),
          'endDate': DateUtil.formatDefaultDate(state.endDate),
           'invalid':state.invalid,
        });
  }

  Future<void> onLoad() async {
    state.currentPage += 1;
    _queryDataDetail(state.currentPage).then((result) {
      if (result.success) {
        state.list?.addAll(result.d!.result!);
        state.hasMore = result.d?.hasMore;
        update(['custom_record']);
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
    _queryDataDetail(state.currentPage).then((result) {
      if (result.success) {
        state.list = result.d?.result;
        state.hasMore = result.d?.hasMore;
        update(['custom_record']);
        state.refreshController.finishRefresh();
        state.refreshController.resetFooter();
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishRefresh();
      }
    });
  }

  void toRepayment() {
    Get.toNamed(RouteConfig.repaymentBill,
        arguments: {'customDTO': state.customDTO})?.then((value) {
      _queryData();
    });
  }

  String getOrderTypeDesc(int type) {
    var list = OrderType.values;
    for (var value in list) {
      if (value.value == type) {
        return value.desc;
      }
    }
    return '';
  }

  void toBillDetail(SalesOrderAccountsDTO salesOrderAccounts) {
    switch (salesOrderAccounts.orderType) {
      case 0:
        Get.toNamed(RouteConfig.saleDetail, arguments: {
          'id': salesOrderAccounts.orderId,
          'orderType': OrderType.PURCHASE
        })?.then((value) {
          if (ProcessStatus.OK == value) {
            onRefresh();
            _queryData();
          }
        });
      case 1:
        Get.toNamed(RouteConfig.saleDetail, arguments: {
          'id': salesOrderAccounts.orderId,
          'orderType': OrderType.SALE
        })?.then((value) {
          if (ProcessStatus.OK == value) {
            onRefresh();
            _queryData();
          }
        });
      case 2:
        Get.toNamed(RouteConfig.saleDetail, arguments: {
          'id': salesOrderAccounts.orderId,
          'orderType': OrderType.SALE_RETURN
        })?.then((value) {
          if (ProcessStatus.OK == value) {
            onRefresh();
            _queryData();
          }
        });
      case 3:
        Get.toNamed(RouteConfig.saleDetail, arguments: {
          'id': salesOrderAccounts.orderId,
          'orderType': OrderType.PURCHASE_RETURN
        })?.then((value) {
          if (ProcessStatus.OK == value) {
            onRefresh();
            _queryData();
          }
        });
      case 4:
        Get.toNamed(RouteConfig.repaymentDetail, arguments: {
          'id': salesOrderAccounts.orderId,
          'orderType': OrderType.REPAYMENT
        })?.then((value) {
          if (ProcessStatus.OK == value) {
            onRefresh();
            _queryData();
          }
        });
      case 5:
        (){};
      case 6:
        Get.toNamed(RouteConfig.costDetail, arguments: {
          'id': salesOrderAccounts.orderId,
          //'orderType':
        })?.then((value) {
          if (ProcessStatus.OK == value) {
            onRefresh();
            _queryData();
          }
        });
      case 7:
        Get.toNamed(RouteConfig.costDetail, arguments: {
          'id': salesOrderAccounts.orderId,
        })?.then((value) {
          if (ProcessStatus.OK == value) {
            onRefresh();
            _queryData();
          }
        });
      case 8:
        (){};
      case 9:
        Get.toNamed(RouteConfig.addStockDetail, arguments: {
          'id': salesOrderAccounts.orderId,
        })?.then((value) {
          if (ProcessStatus.OK == value) {
            onRefresh();
            _queryData();
          }
        });
      case 10:
        Get.toNamed(RouteConfig.saleDetail, arguments: {
          'id': salesOrderAccounts.orderId,
          'orderType':OrderType.REFUND
        })?.then((value) {
          if (ProcessStatus.OK == value) {
            onRefresh();
            _queryData();
          }
        });
      default:
        throw Exception('网络错误');
    }
  }

  //筛选里清空条件
  void clearCondition() {
    state.startDate = DateTime.now().subtract(Duration(days: 90));
    state.endDate = DateTime.now();
    state.orderType = null;
    state.invalid = 0;
    update(['date_range', 'supplier_detail_order_type', 'invalid_visible']);
  }

  //筛选里‘确定’
  void confirmCondition() {
    onRefresh();
    Get.back();
  }

  Future<void> customDetail() async {
    await Get.toNamed(RouteConfig.customDetail,
        arguments: {'customId': state.customDTO?.id})?.then((result) {
      _queryData();
    });
  }

  //筛选里账单情况
  bool checkOrderStatus(int? orderStatus) {
    return state.orderType == orderStatus;
  }

  String creditAmount(SalesOrderAccountsDTO? statisticsCustomOrderDTO) {
    if ((statisticsCustomOrderDTO?.orderType == OrderType.SALE_RETURN.value) ||
        (statisticsCustomOrderDTO?.orderType ==
            OrderType.PURCHASE_RETURN.value)) {
      return '￥- ${statisticsCustomOrderDTO?.creditAmount}';
    } else if(statisticsCustomOrderDTO?.orderType == OrderType.CREDIT.value){
      return '';
    }else{
      return DecimalUtil.formatAmount(statisticsCustomOrderDTO?.creditAmount);
    }
  }

  String totalAmount(SalesOrderAccountsDTO? statisticsCustomOrderDTO) {
    if ((statisticsCustomOrderDTO?.orderType == OrderType.SALE_RETURN.value) ||
        (statisticsCustomOrderDTO?.orderType ==
            OrderType.PURCHASE_RETURN.value)) {
      return '￥- ${statisticsCustomOrderDTO?.totalAmount}';
    } else {
      return DecimalUtil.formatAmount(statisticsCustomOrderDTO?.totalAmount);
    }
  }

  String totalName(SalesOrderAccountsDTO salesOrderAccounts) {
    switch (salesOrderAccounts.orderType) {
      case 0: return '实付：';
      case 1: return '实收：';
      case 2: return '实退：';
      case 3: return '实退：';
      case 4: return '还款：';
      case 5:return '赊账：';
      case 6:return '收入：';
      case 7:return '费用：';
      case 8:return '汇款：';
      case 9:return '入库：';
      case 10:return '退款：';
      default:
        throw Exception('网络错误');
    }
  }

  String creditName(SalesOrderAccountsDTO salesOrderAccounts) {
    switch (salesOrderAccounts.orderType) {
      case 0: return '赊账：';
      case 1: return '赊账：';
      case 2: return '赊账：';
      case 3: return '赊账：';
      case 4: return '剩余欠款：';
      case 5:return'';
      case 6:return '收入：';
      case 7:return '费用：';
      case 8:return '汇款：';
      case 9:return '入库：';
      case 10:return '退赊账：';
      default:
        throw Exception('网络错误');
    }
  }
}
