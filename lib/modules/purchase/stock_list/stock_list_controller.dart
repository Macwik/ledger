import 'package:decimal/decimal.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/product_api.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/entity/product/product_classify_list_dto.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/enum/sales_channel.dart';
import 'package:ledger/enum/stock_list_type.dart';
import 'package:ledger/enum/unit_type.dart';
import 'package:ledger/http/base_page_entity.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/widget/permission/permission_widget.dart';
import 'stock_list_state.dart';

class StockListController extends GetxController {
  final StockListState state = StockListState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['select'] != null) {
      state.select = arguments['select'];
    }
    update(['stock_list_bottom']); //不执行刷新
    _queryProductClassifyList();
    onRefresh();
  }

  void showBottomSheet(
    BuildContext context,
    ProductDTO? stockDTO,
  ) {
    List<Widget> actions = [];
    if (stockDTO?.used == 0) {
      actions.add(CupertinoActionSheetAction(
        onPressed: () {
          toDeleteProduct(stockDTO?.id);
        },
        child: Text('删除货物'),
        isDestructiveAction: true,
      ));
    }

    actions.add(PermissionWidget(
      permissionCode: PermissionCode.stock_list_invalid_product_permission,
      child: CupertinoActionSheetAction(
          onPressed: () {
            toDeactivateProduct(stockDTO);
          },
          child: Text(stockDTO?.invalid == 1 ? '启用商品' : '停用商品')),
    ));

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: actions,
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
            },
            child: Text('取消'),
          ),
        );
      },
    );
  }

  void toDeleteProduct(int? id) {
    if ((state.productDTO?.unitDetailDTO?.stock == Decimal.zero) ||
        (state.productDTO == null) ||
        (state.productDTO?.unitDetailDTO?.masterStock == Decimal.zero)) {
      Get.dialog(
        Warning(
          cancel: '取消',
          confirm: '确定',
          content: '确认删除此商品吗？',
          onCancel: () => Get.back(),
          onConfirm: () {
            Http().network(Method.delete, ProductApi.product_remove,
                queryParameters: {
                  'id': id,
                }).then((result) {
              if (result.success) {
                onRefresh();
                Toast.showSuccess('删除成功');
                Get.back();
              } else {
                Toast.showError(result.m.toString());
              }
            });
          },
        ),
        barrierDismissible: false,
      );
    } else {
      Warning(
          confirm: '确定',
          content: '货物库存不为零，不能删除',
          onConfirm: () {
            Get.back();
          });
    }
  }

  void toDeactivateProduct(ProductDTO? stockDTO) {
    Get.dialog(
      Warning(
        cancel: '取消',
        confirm: '确定',
        content: stockDTO?.invalid == 0 ? '确认停用此商品吗？' : '确定启用此商品吗？',
        onCancel: () => Get.back(),
        onConfirm: () {
          if (stockDTO?.invalid == 0) {
            Http().network(Method.put, ProductApi.product_invalid,
                queryParameters: {
                  'id': stockDTO?.id,
                }).then((result) {
              if (result.success) {
                Toast.showSuccess('成功停用');
                onRefresh();
                Get.back();
              } else {
                Toast.showError(result.m.toString());
              }
            });
          } else {
            Http().network(Method.put, ProductApi.product_enable,
                queryParameters: {
                  'id': stockDTO?.id,
                }).then((result) {
              if (result.success) {
                Toast.showSuccess('成功启用');
                onRefresh();
                Get.back();
              } else {
                Toast.showError(result.m.toString());
              }
            });
          }
        },
      ),
      barrierDismissible: false,
    );
  }

  String judgeUnit(ProductDTO? productDTO) {
    if (null == productDTO) {
      return '-';
    }
    if (productDTO.unitDetailDTO?.unitType == UnitType.SINGLE.value) {
      return '${DecimalUtil.formatDecimalNumber(productDTO.unitDetailDTO?.stock)} ${productDTO.unitDetailDTO?.unitName}';
    } else {
      return '${DecimalUtil.formatDecimalNumber(productDTO.unitDetailDTO?.masterStock)} ${productDTO.unitDetailDTO?.masterUnitName} | ${productDTO.unitDetailDTO?.slaveStock ?? '0'} ${productDTO.unitDetailDTO?.slaveUnitName}';
    }
  }

  Future<void> _queryProductClassifyList() async {
    await Http()
        .network<ProductClassifyListDTO>(
            Method.post, ProductApi.product_classify_product_list)
        .then((result) {
      if (result.success) {
        state.productClassifyListDTO = result.d!;
        state.productList = result.d?.productList;
        update(['product_classify_list']);
      } else {
        Toast.showError(result.m.toString());
      }
    });
  }

  Future<BasePageEntity<ProductDTO>> _queryData(int currentPage) async {
    return await Http()
        .networkPage<ProductDTO>(Method.post, ProductApi.stockList, data: {
      'page': currentPage,
      'invalid': state.invalid,
      'productClassify': state.selectType,
      'searchContent': state.searchContent,
    });
  }

  Future<void> onLoad() async {
    state.currentPage += 1;
    _queryData(state.currentPage).then((result) {
      if (result.success) {
        state.productList!.addAll(result.d!.result!);
        state.hasMore = result.d!.hasMore;
        update(['product_classify_list']);
        state.refreshController.finishLoad(state.hasMore ?? false
            ? IndicatorResult.success
            : IndicatorResult.noMore);
      } else {
        Toast.showError(result.m.toString());
        state.refreshController.finishLoad(IndicatorResult.fail);
      }
    });
  }

  Future<void> onRefresh() async {
    state.currentPage = 1;
    _queryData(state.currentPage).then((result) {
      if (result.success) {
        state.productList = result.d?.result;
        state.hasMore = result.d?.hasMore;
        update(['product_classify_list']);
        state.refreshController.finishRefresh();
        state.refreshController.resetFooter();
      } else {
        Toast.showError(result.m.toString());
        state.refreshController.finishRefresh();
      }
    });
  }

  void toAddProduct() {
    Get.toNamed(RouteConfig.addProduct)?.then((result) {
      _queryProductClassifyList();
      onRefresh();
    });
  }

  void productDetail(ProductDTO? stockDTO) {
    if (state.select == StockListType.DETAIL) {
      Get.toNamed(RouteConfig.goodsDetail, arguments: {'productDTO': stockDTO})
          ?.then((value) {
        onRefresh();
      });
    } else {
      Get.back(result: stockDTO);
    }
  }

  String getSalesChannel(int? channel) {
    for (var value in SalesChannel.values) {
      if (value.value == channel) {
        return value.desc;
      }
    }
    return '';
  }

  void searchStockList(String value) {
    state.searchContent = value;
    onRefresh();
  }

  //筛选里清空条件
  void clearCondition() {
    state.invalid = 0;
    update(['switch']);
  }

  //筛选里‘确定’
  void confirmCondition() {
    onRefresh();
    Get.back();
  }

  void switchSelectType(int? id) {
    if (null == id) {
      return;
    }
    state.selectType = id;
    onRefresh();
  }
}
