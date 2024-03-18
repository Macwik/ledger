import 'package:get/get.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/res/export.dart';

import 'more_state.dart';

class MoreController extends GetxController {
  final MoreState state = MoreState();

  Object? toSale(int index) {
    switch (index) {
      case 0:
        return Get.toNamed(RouteConfig.retailBill, arguments: {'orderType': OrderType.SALE});
      case 1:
        return  Get.toNamed(RouteConfig.retailBill, arguments: {'orderType': OrderType.SALE_RETURN});
      case 2:
        return Get.toNamed(RouteConfig.retailBill, arguments: {'orderType': OrderType.REFUND});
      case 3:
        return   Get.toNamed(RouteConfig.saleRecord, arguments: {'orderType': OrderType.SALE,'index': 0});
      case 4:
        return   Get.toNamed(RouteConfig.customRecord,arguments: {'initialIndex': 0, 'isSelectCustom': false});
      default:
        throw Exception('Unsupported ChangePasswordType');
    }
  }

  Object? toPurchase(int index) {
    switch (index) {
      case 0:
        return Get.toNamed(RouteConfig.saleBill, arguments: {'orderType': OrderType.PURCHASE});
      case 1:
        return  Get.toNamed(RouteConfig.saleBill, arguments: {'orderType': OrderType.PURCHASE_RETURN});
      case 2:
        return   Get.toNamed(RouteConfig.saleRecord, arguments: {'orderType': OrderType.PURCHASE});
      case 3:
        return   Get.toNamed(RouteConfig.customRecord,arguments: {'initialIndex': 1, 'isSelectCustom': false});
      default:
        throw Exception('Unsupported ChangePasswordType');
    }
  }

  Object? toStore(int index) {
    switch (index) {
      case 0:
        return Get.toNamed(RouteConfig.retailBill, arguments: {'orderType': OrderType.SALE});
      case 1:
        return  Get.toNamed(RouteConfig.retailBill, arguments: {'orderType': OrderType.SALE_RETURN});
      case 2:
        return Get.toNamed(RouteConfig.retailBill, arguments: {'orderType': OrderType.REFUND});
      case 3:
        return   Get.toNamed(RouteConfig.saleRecord, arguments: {'orderType': OrderType.SALE,'index': 0});
      case 4:
        return   Get.toNamed(RouteConfig.customRecord,arguments: {'initialIndex': 0, 'isSelectCustom': false});
      default:
        throw Exception('Unsupported ChangePasswordType');
    }
  }

  Object? toFund(int index) {
    switch (index) {
      case 0:
        return Get.toNamed(RouteConfig.retailBill, arguments: {'orderType': OrderType.SALE});
      case 1:
        return  Get.toNamed(RouteConfig.retailBill, arguments: {'orderType': OrderType.SALE_RETURN});
      case 2:
        return Get.toNamed(RouteConfig.retailBill, arguments: {'orderType': OrderType.REFUND});
      case 3:
        return   Get.toNamed(RouteConfig.saleRecord, arguments: {'orderType': OrderType.SALE,'index': 0});
      case 4:
        return   Get.toNamed(RouteConfig.customRecord,arguments: {'initialIndex': 0, 'isSelectCustom': false});
      default:
        throw Exception('Unsupported ChangePasswordType');
    }
  }

  Object? toAccount(int index) {
    switch (index) {
      case 0:
        return Get.toNamed(RouteConfig.retailBill, arguments: {'orderType': OrderType.SALE});
      case 1:
        return  Get.toNamed(RouteConfig.retailBill, arguments: {'orderType': OrderType.SALE_RETURN});
      case 2:
        return Get.toNamed(RouteConfig.retailBill, arguments: {'orderType': OrderType.REFUND});
      case 3:
        return   Get.toNamed(RouteConfig.saleRecord, arguments: {'orderType': OrderType.SALE,'index': 0});
      case 4:
        return   Get.toNamed(RouteConfig.customRecord,arguments: {'initialIndex': 0, 'isSelectCustom': false});
      default:
        throw Exception('Unsupported ChangePasswordType');
    }
  }
}
