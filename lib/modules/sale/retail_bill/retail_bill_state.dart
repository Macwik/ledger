import 'package:decimal/decimal.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/entity/payment/order_pay_dialog_result.dart';
import 'package:ledger/entity/payment/payment_method_dto.dart';
import 'package:ledger/entity/product/product_classify_list_dto.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/entity/product/product_shopping_car_dto.dart';
import 'package:ledger/entity/product/product_stock_adjust_request.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/store/store_controller.dart';

class RetailBillState {
  RetailBillState() {
    ///Initialize variables
  }

  final formKey = GlobalKey<FormBuilderState>();

  OrderType orderType = OrderType.SALE;

  OrderPayDialogResult? orderPayDialogResult;

  List<PaymentMethodDTO>? paymentMethods;

  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  String? ledgerName = StoreController.to.getUser()?.activeLedger?.ledgerName;

  DateTime date = DateTime.now();

  //选择客户
  CustomDTO? customDTO;

  int currentPage = 1;
  bool? hasMore;

  //货物分组
  ProductClassifyListDTO? productClassifyListDTO;
  List<ProductDTO>? productList;

  String? searchContent = '';

  int selectType = 1;

  final double menuItemHeight = 48.0; //一级菜单高度
  final ScrollController menuController = ScrollController(); // 一级滚动控制

  Decimal totalAmount = Decimal.zero;

  int? pendingOrderNum = 0;

  //入库商品
  ProductShoppingCarDTO? productAddStockRequest;

  //销售、退货开单购物车商品
  List<ProductShoppingCarDTO> shoppingCarList = [];
  List<ProductShoppingCarDTO> shoppingCarCheckList =[];

  //调整库存
  ProductStockAdjustRequest? productStockAdjustRequest;


}
