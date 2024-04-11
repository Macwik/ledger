import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/product_api.dart';
import 'package:ledger/entity/product/product_sales_credit_dto.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/unit_type.dart';
import 'package:ledger/http/base_page_entity.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/toast_util.dart';

import 'product_credit_state.dart';

class ProductCreditController extends GetxController {
  final ProductCreditState state = ProductCreditState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['id'] != null) {
      state.productId = arguments['id'];
    }
    if ((arguments != null) && arguments['creditAmount'] != null) {
      state.creditAmount = arguments['creditAmount'];
    }
    if ((arguments != null) && arguments['orderType'] != null) {
      state.orderTypeList = arguments['orderType'];
    }
    onRefresh();
  }

  Future<BasePageEntity<ProductSalesCreditDTO>> _queryData(
      int currentPage) async {
    return await Http().networkPage<ProductSalesCreditDTO>(
        Method.post, ProductApi.product_credit_statistics,
        data: {
          'page': currentPage,
          'productId': state.productId,
          'startDate': DateUtil.formatDefaultDate(state.startDate),
          'endDate': DateUtil.formatDefaultDate(state.endDate),
          'orderTypeList': state.orderTypeList,
        });
  }

  String judgeUnit(ProductSalesCreditDTO productSalesCredit) {
    if (productSalesCredit.unitType == UnitType.SINGLE.value) {
      return '${productSalesCredit.number ?? ''} | ${productSalesCredit.unitName ?? ''}';
    } else {
      return '${productSalesCredit.masterNumber ?? ''} ${productSalesCredit.masterUnitName ?? ''} | ${productSalesCredit.slaveNumber ?? ''} ${productSalesCredit.slaveUnitName ?? ''}';
    }
  }

  Future<void> onLoad() async {
    state.currentPage += 1;
    _queryData(state.currentPage).then((result) {
      if (result.success) {
        state.items!.addAll(result.d!.result!);
        state.hasMore = result.d!.hasMore;
        update(['goods_detail_product_credit_statistics']);
        state.refreshController.finishLoad(state.hasMore ?? false
            ? IndicatorResult.success
            : IndicatorResult.noMore);
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishLoad(IndicatorResult.fail);
      }
    });
  }

  Future<void> onRefresh() async {
    state.currentPage = 1;
    _queryData(state.currentPage).then((result) {
      if (result.success) {
        state.items = result.d!.result!;
        state.hasMore = result.d!.hasMore;
        update(['goods_detail_product_credit_statistics']);
        state.refreshController.finishRefresh();
        state.refreshController.resetFooter();
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishRefresh();
      }
    });
  }

  void toSalesDetail(ProductSalesCreditDTO? productSalesCredit) {
    Get.toNamed(RouteConfig.saleDetail, arguments: {
      'id': productSalesCredit?.orderId,
      'orderType': orderType(productSalesCredit?.orderType)
    });
  }

  OrderType orderType(int? orderType) {
    switch (orderType) {
      case 0:
        return OrderType.PURCHASE;
      case 1:
        return OrderType.SALE;
      case 2:
        return OrderType.SALE_RETURN;
      case 3:
        return OrderType.PURCHASE_RETURN;
      default:
        throw Exception('销售单');
    }
  }

  String checkOrderType(int? orderType) {
    switch (orderType) {
      case 0:
        return '采购单';
      case 1:
        return '销售单';
      case 2:
        return '销售退货单';
      case 3:
        return '采购退货单';
      case 10:
        return '退款单';
      default:
        throw Exception('销售单');
    }
  }
}
