import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/cost_income_api.dart';
import 'package:ledger/entity/costIncome/external_order_statistic_dto.dart';
import 'package:ledger/http/base_page_entity.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/loading.dart';

import 'product_cost_detail_state.dart';

class ProductCostDetailController extends GetxController
    with GetSingleTickerProviderStateMixin
    implements DisposableInterface {
  final ProductCostDetailState state = ProductCostDetailState();

  late TabController tabController;

  @override
  void onInit() {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['discount'] != null) {
      state.discount = arguments['discount'];
    }
    if ((arguments != null) && arguments['productId'] != null) {
      state.productId = arguments['productId'];
    }
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      var index = tabController.index;
      state.index = index;
      onRefresh();
    });
    super.onInit();
    onRefresh();
  }

  Future<void> onLoad() async {
    state.currentPage += 1;
    await _queryData(state.currentPage).then((result) {
      if (true == result.success) {
        state.list!.addAll(result.d!.result!);
        state.hasMore = result.d?.hasMore;
        update(['product_cost_detail']);
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
    Loading.showDuration();
    await _queryData(state.currentPage).then((result) {
      Loading.dismiss();
      if (true == result.success) {
        state.list = result.d?.result;
        state.hasMore = result.d?.hasMore;
        state.refreshController.finishRefresh();
        state.refreshController.resetFooter();
        update(['product_cost_detail']);
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishRefresh();
      }
    });
  }

  Future<BasePageEntity<ExternalOrderStatisticDTO>> _queryData(
      int currentPage) async {
    return await Http().networkPage<ExternalOrderStatisticDTO>(
        Method.post, CostIncomeApi.product_cost_statistic,
        queryParameters: {
          'productId': state.productId,
          'orderType': state.index,
          'discount': state.discount,
          'page': currentPage,
          'size':10
        });
  }
}
