import 'package:easy_refresh/easy_refresh.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/entity/statistics/sales_order_accounts_dto.dart';

class SupplierDetailState {

  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  int currentPage = 1;
  bool? hasMore;

  //已作废单据选择
  int? invalid = 0;

  List<SalesOrderAccountsDTO>? list;

  CustomDTO ? customDTO;

  CustomDTO ? custom;

  String? dateRange;

  int? orderType;//账单类型

  DateTime startDate = DateTime.now().subtract(Duration(days: 7));
  DateTime endDate = DateTime.now();


  SupplierDetailState() {
    ///Initialize variables
  }
}
