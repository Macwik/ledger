import 'package:decimal/decimal.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/entity/draft/order_draft_detail_dto.dart';
import 'package:ledger/entity/payment/order_pay_dialog_result.dart';
import 'package:ledger/entity/payment/payment_method_dto.dart';
import 'package:ledger/entity/product/product_classify_list_dto.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/entity/product/product_shopping_car_dto.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/store/store_controller.dart';

class PendingRetailBillState {
  PendingRetailBillState() {
    ///Initialize variables
  }

  int currentPage = 1;
  bool? hasMore;

  //货物分组
  ProductClassifyListDTO? productClassifyListDTO;
  List<ProductDTO>? productList;

  DateTime date = DateTime.now();

  final double menuItemHeight = 48.0; //一级菜单高度
  final ScrollController menuController = ScrollController(); // 一级滚动控制

  //销售、退货开单购物车商品
  List<ProductShoppingCarDTO>? shoppingCarList = [];

  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  String? ledgerName = StoreController.to.getUser()?.activeLedger?.ledgerName;

  OrderType orderType = OrderType.SALE;

  int? pendingOrderNum = 0;

  String? searchContent = '';

  Decimal totalAmount = Decimal.zero;

  OrderDraftDetailDTO? orderDraftDetailDTO;

  OrderPayDialogResult? orderPayDialogResult;

  int selectType = 1;

  //选择客户
  CustomDTO? customDTO;

  int? draftId;

  List<PaymentMethodDTO>? paymentMethods;
}
