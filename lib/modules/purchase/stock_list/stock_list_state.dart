import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:ledger/entity/product/product_classify_list_dto.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/enum/stock_list_type.dart';

class StockListState {
  //已作废单据选择
  int? invalid = 0;

  final double menuItemHeight = 48.0; //一级菜单高度
  final ScrollController menuController = ScrollController(); // 一级滚动控制

  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  ProductClassifyListDTO? productClassifyListDTO;
  List<ProductDTO>? productList;

  int selectType = 1;

  int currentPage = 1;

  bool? hasMore;

  StockListType select = StockListType.DETAIL;

  ProductDTO? productDTO;

  StockListState();

  String? searchContent = '';

  ProcessStatus? bottomShow = ProcessStatus.FAIL;


}

//enum StockListType { DETAIL, SELECT_PRODUCT }
