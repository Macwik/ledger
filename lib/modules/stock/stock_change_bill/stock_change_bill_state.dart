import 'package:ledger/entity/product/product_stock_adjust_request.dart';

class StockChangeBillState {
  StockChangeBillState() {
    ///Initialize variables
  }

  List<ProductStockAdjustRequest> productStockAdjustRequest = [];

  DateTime date = DateTime.now();

  bool visible = false;
}
