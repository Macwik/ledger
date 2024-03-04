import 'package:get/get.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/route/route_config.dart';
import 'purchase_state.dart';

class PurchaseController extends GetxController {
  final PurchaseState state = PurchaseState();

  void toPurchaseBill() {
    Get.toNamed(RouteConfig.saleBill, arguments: {'orderType': OrderType.PURCHASE});
  }

  toSaleReturnBill() {
    Get.toNamed(RouteConfig.saleBill, arguments: {'orderType': OrderType.PURCHASE_RETURN});
  }
}
