import 'package:ledger/entity/order/order_detail_dto.dart';
import 'package:ledger/enum/order_type.dart';

class AddStockDetailState {
  AddStockDetailState() {
    ///Initialize variables
  }

  OrderDetailDTO? orderDetailDTO;

  OrderType orderType = OrderType.SALE;

  int? id;
}
