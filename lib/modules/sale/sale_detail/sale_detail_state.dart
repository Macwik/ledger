import 'package:ledger/entity/order/order_detail_dto.dart';
import 'package:ledger/enum/order_type.dart';


class SaleDetailState {
 OrderDetailDTO? orderDetailDTO;

 int? id;

 OrderType orderType = OrderType.SALE;

  SaleDetailState() {
    ///Initialize variables
  }
}


