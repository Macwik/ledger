import 'package:easy_refresh/easy_refresh.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/entity/product/product_sales_statistics_dto.dart';
import 'package:ledger/entity/product/stock_change_record_dto.dart';

class GoodsDetailState {
  final refreshController = EasyRefreshController();
  int currentPage = 1;

  List<StockChangeRecordDTO>? items;//需要修改<里的内容>

  ProductDTO? productDTO;

  ProductSalesStatisticsDTO? productSalesStatisticsDTO;

  DateTime startDate = DateTime.now().subtract(Duration(days: 90));
  DateTime endDate = DateTime.now();

  GoodsDetailState() {
    ///Initialize variables
  }
}
