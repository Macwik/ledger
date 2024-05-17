import 'package:easy_refresh/easy_refresh.dart';
import 'package:ledger/entity/costIncome/external_order_statistic_dto.dart';

class ProductCostDetailState {
  ProductCostDetailState() {
    ///Initialize variables
  }

  int? index;

  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  bool? hasMore;

  int currentPage = 1;

  List<ExternalOrderStatisticDTO>? list;

  int? productId;

  int? discount;//产地：0 销售地：1
}
