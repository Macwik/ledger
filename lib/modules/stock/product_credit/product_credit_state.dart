import 'package:easy_refresh/easy_refresh.dart';
import 'package:decimal/decimal.dart';
import 'package:ledger/entity/product/product_sales_credit_dto.dart';

class ProductCreditState {
  ProductCreditState() {
    ///Initialize variables
  }
  int ? productId;

  Decimal? creditAmount;

  ProductSalesCreditDTO ? productSalesCreditDTO;

  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  int currentPage = 1;

  bool? hasMore;

  List<ProductSalesCreditDTO>? items;

  DateTime startDate = DateTime.now().subtract(Duration(days: 90));
  DateTime endDate = DateTime.now();

  List<int>? orderTypeList;

}
