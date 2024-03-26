import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/statistics_api.dart';
import 'package:ledger/entity/home/sales_product_statistics_dto.dart';
import 'package:ledger/entity/repayment/custom_credit_dto.dart';
import 'package:ledger/entity/statistics/external_order_base_dto.dart';
import 'package:ledger/entity/statistics/money_payment_dto.dart';
import 'package:ledger/entity/statistics/purchase_money_statistics_dto.dart';
import 'package:ledger/entity/statistics/sales_money_statistic_dto.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/unit_type.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';

import 'daily_account_state.dart';

class DailyAccountController extends GetxController
    with GetSingleTickerProviderStateMixin
    implements DisposableInterface {
  final DailyAccountState state = DailyAccountState();

  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      var index = tabController.index;
      state.initialIndex = index;
      switchDailyAccountIndex(index);
    });
    super.onInit();
  }

  void initState() {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['initialIndex'] != null) {
      state.initialIndex = arguments['initialIndex'];
    }
    if ((arguments != null) && arguments['startDateSalesProduct'] != null) {
      state.startDateSalesProduct = arguments['startDateSalesProduct'];
    }
    switchDailyAccountIndex(state.initialIndex);
  }

  //销售资金情况统计
  void querySalesMoneyStatistics() {
    Http().network<SalesMoneyStatisticDTO>(
        Method.post, StatisticsApi.sales_money_statistics,
        data: {
          'queryDate': DateUtil.formatDefaultDate(state.dateSaleMoney),
        }).then((result) {
      if (result.success) {
        state.salesMoneyStatisticDTO = result.d;
        update(['daily_sales_money_statistics']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  //采购情况统计
  // Future<BasePageEntity<PurchaseMoneyStatisticsDTO>>
  //     queryPurchaseMoneyStatistics(int currentPage) async {
  //   return await Http().networkPage<PurchaseMoneyStatisticsDTO>(
  //       Method.post, StatisticsApi.purchase_money_statistics,
  //       data: {
  //         'page': currentPage,
  //         'startDate': DateUtil.formatDefaultDate(state.startDatePurchaseMoney),
  //         'endDate': DateUtil.formatDefaultDate(state.endDatePurchaseMoney),
  //       });
  // }

  //销售情况统计
  void querySalesProductStatistics() {
    Http().network<List<SalesProductStatisticsDTO>>(
        Method.post, StatisticsApi.sale_product_statistics,
        data: {
          'startDate': DateUtil.formatDefaultDate(state.startDateSalesProduct),
          'endDate': DateUtil.formatDefaultDate(state.endDateSalesProduct)
        }).then((result) {
      if (result.success) {
        state.salesProductStatisticsDTO = result.d;
        update(['daily_sales_product_statistics', 'sales_product_data_range']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  //欠款情况统计
  void queryCreditMoneyStatistics() {
    Http().network<List<CustomCreditDTO>>(
        Method.post, StatisticsApi.custom_credit,
        data: {
          'queryDate': DateUtil.formatDefaultDate(state.dateCreditMoney),
        }).then((result) {
      if (result.success) {
        state.customCreditDTO = result.d;
        if (state.customCreditDTO?.isEmpty ?? false) {
          state.totalCreditAmount = Decimal.zero;
        } else {
          state.totalCreditAmount = state.customCreditDTO
              ?.map((e) => e.creditAmount ?? Decimal.zero)
              .reduce((value, element) => value + element);
        }
        update(['daily_custom_credit', 'daily_custom_credit_amount']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  // Future<void> onLoad() async {
  //   state.currentPage += 1;
  //   await queryPurchaseMoneyStatistics(state.currentPage).then((result) {
  //     if (result.success) {
  //       state.purchaseMoneyStatistics?.addAll(result.d!.result!);
  //       state.hasMore = result.d!.hasMore;
  //       update(['daily_purchase_money']);
  //       state.refreshController.finishLoad(state.hasMore ?? false
  //           ? IndicatorResult.success
  //           : IndicatorResult.noMore);
  //     } else {
  //       Toast.show(result.m.toString());
  //       state.refreshController.finishLoad(IndicatorResult.fail);
  //     }
  //   });
  // }

  // Future<void> onRefresh() async {
  //   state.currentPage = 1;
  //   await queryPurchaseMoneyStatistics(state.currentPage).then((result) {
  //     if (result.success) {
  //       state.purchaseMoneyStatistics = result.d?.result;
  //       state.hasMore = result.d?.hasMore;
  //       update(['daily_purchase_money']);
  //       state.refreshController.finishRefresh();
  //       state.refreshController.resetFooter();
  //     } else {
  //       Toast.show(result.m.toString());
  //       state.refreshController.finishRefresh();
  //     }
  //   });
  // }

  //销售资金拉取日期
  Future<void> pickerSaleMoneyDate(BuildContext context) async {
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
      state.dateSaleMoney = picked;
      querySalesMoneyStatistics();
      update(['daily_sales_money_date']);
    }
  }

  //赊账资金拉取日期
  Future<void> pickerCreditMoneyDate(BuildContext context) async {
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
      state.dateCreditMoney = picked;
      queryCreditMoneyStatistics();
      update(['daily_credit_money_date']);
    }
  }

  String judgeUnit(SalesProductStatisticsDTO? salesProductStatisticsDTO) {
    if (null == salesProductStatisticsDTO) {
      return '-';
    }
    if (salesProductStatisticsDTO.unitType == UnitType.SINGLE.value) {
      return '${DecimalUtil.formatDecimalNumber(salesProductStatisticsDTO.number)} ${salesProductStatisticsDTO.unitName}';
    } else {
      return '${DecimalUtil.formatDecimalNumber(salesProductStatisticsDTO.masterNumber)} ${salesProductStatisticsDTO.masterUnitName} | ${DecimalUtil.formatDecimalNumber(salesProductStatisticsDTO.slaveNumber)} ${salesProductStatisticsDTO.slaveUnitName}';
    }
  }

  void switchDailyAccountIndex(int index) {
    state.initialIndex = index;
    switch (index) {
      case 0:
        return querySalesMoneyStatistics();
      case 1:
        return querySalesProductStatistics();
      case 2:
        return queryCreditMoneyStatistics();
      default:
        throw Exception('无此页面');
    }
  }

  // void changeDatePurchaseMoney() {
  //   onRefresh();
  // }

  void changeDateSaleProduct() {
    querySalesProductStatistics();
  }

  String calculate(MoneyPaymentDTO? moneyPayment) {
    if (null == moneyPayment) {
      return DecimalUtil.formatAmount(Decimal.zero);
    }
    return DecimalUtil.formatAmount((moneyPayment.salesAmount ?? Decimal.zero) +
        (moneyPayment.incomeAmount ?? Decimal.zero) +
        (moneyPayment.costAmount ?? Decimal.zero) +
        (moneyPayment.repaymentAmount ?? Decimal.zero));
  }

  String getCostTotalAmount(
      List<ExternalOrderBaseDTO>? externalOrderBaseDTOList) {
    if (externalOrderBaseDTOList?.isEmpty ?? true) {
      return DecimalUtil.formatAmount(Decimal.zero);
    } else {
      return DecimalUtil.formatAmount(externalOrderBaseDTOList
          ?.map((e) => e.totalAmount ?? Decimal.zero)
          .reduce((value, element) => value + element));
    }
  }

  void toCostDetail(PurchaseMoneyStatisticsDTO? purchaseMoneyStatistics) {
    Get.offNamed(RouteConfig.dailyAccountCostDetail,
        arguments: {'purchaseMoneyStatistics': purchaseMoneyStatistics});
  }

  void toSalesDetail(CustomCreditDTO customCreditDTO) {
    Get.toNamed(RouteConfig.saleDetail, arguments: {
      'id': customCreditDTO.orderId,
      'orderType': orderType(customCreditDTO.creditType)
    });
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
      default:
        throw Exception('销售单');
    }
  }

// void toPurchaseDetail(PurchaseMoneyStatisticsDTO purchaseMoneyStatistics) {
//   Get.toNamed(RouteConfig.saleDetail, arguments: {
//     'orderType': purchaseMoneyStatistics.orderDTO?.orderType == 0
//         ? OrderType.PURCHASE
//         : OrderType.PURCHASE_RETURN,
//     'id': purchaseMoneyStatistics.orderDTO?.id
//   });
// }
}
