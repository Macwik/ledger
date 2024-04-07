import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:ledger/entity/product/product_classify_list_dto.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/entity/product/product_shopping_car_dto.dart';
import 'package:ledger/entity/product/product_stock_adjust_request.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/page_to_type.dart';

class ShoppingCarState {
  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  int currentPage = 1;
  bool? hasMore;

  //货物分组
  ProductClassifyListDTO? productClassifyListDTO;
  List<ProductDTO>? productList;

  int selectType = 1;

  final double menuItemHeight = 48.0; //一级菜单高度
  final ScrollController menuController = ScrollController(); // 一级滚动控制

  //购物车商品
  List<ProductShoppingCarDTO> shoppingCarList = [];
  //调整库存
  ProductStockAdjustRequest? productStockAdjustRequest;
  //入库商品
  // ProductShoppingCarDTO? productAddStockRequest;

  PageToType? pageToType;

  OrderType? orderType;

  String? searchContent ='';

  ShoppingCarState() {
    ///Initialize variables
  }
}
