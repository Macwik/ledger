import 'package:decimal/decimal.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:ledger/entity/home/sales_product_statistics_dto.dart';
import 'package:ledger/entity/repayment/custom_credit_dto.dart';
import 'package:ledger/entity/statistics/purchase_money_statistics_dto.dart';
import 'package:ledger/entity/statistics/sales_money_statistic_dto.dart';

class DailyAccountState {

  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );


  // DateTime startDatePurchaseMoney = DateTime.now().subtract(Duration(days: 2));
  // DateTime endDatePurchaseMoney = DateTime.now();

  DateTime startDateSalesProduct = DateTime.now().subtract(Duration(days: 90));
  DateTime endDateSalesProduct = DateTime.now();

  DateTime dateSaleMoney = DateTime.now();

  DateTime dateCreditMoney = DateTime.now();

  //销售资金
  SalesMoneyStatisticDTO? salesMoneyStatisticDTO;

  //采购资金
  List<PurchaseMoneyStatisticsDTO>? purchaseMoneyStatistics;


  //销售情况
  List<SalesProductStatisticsDTO>? salesProductStatisticsDTO;

  //欠款
  List<CustomCreditDTO>? customCreditDTO;

  int currentPage = 1;

  bool? hasMore;

  int initialIndex = 0;

  DailyAccountState() {
    ///Initialize variables
  }

  Decimal? totalCreditAmount;

  Decimal? totalSalesAmount;

}
