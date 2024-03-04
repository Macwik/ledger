import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/order_api.dart';
import 'package:ledger/entity/draft/order_draft_dto.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/warning.dart';

import 'pending_order_state.dart';

class PendingOrderController extends GetxController {
  final PendingOrderState state = PendingOrderState();

  Future<void> initState() async {
    onRefresh();
  }

  _queryData(int currentPage) {
    return  Http().networkPage<OrderDraftDTO>(Method.post, OrderApi.pending_order_list, data: {
      'page': currentPage,
      'searchContent': state.searchContent,
      'startDate': DateUtil.formatDefaultDate(DateTime.now().subtract(Duration(days: 30))),
      'endDate': DateUtil.formatDefaultDate(DateTime.now()),
    });
  }


  Future<void> onRefresh() async {
    state.currentPage = 1;
    await _queryData(state.currentPage).then((result) {
      if (true == result.success) {
        state.list = result.d?.result;
        state.hasMore = result.d?.hasMore;
        state.refreshController.finishRefresh();
        state.refreshController.resetFooter();
        update(['pending_order']);
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishRefresh();
      }
    });
  }

  Future<void> onLoad() async {
    state.currentPage += 1;
    await _queryData(state.currentPage).then((result) {
      if (true == result.success) {
        state.list!.addAll(result.d!.result!);
        state.hasMore = result.d?.hasMore;
        update(['pending_order']);
        state.refreshController.finishLoad(state.hasMore ?? false
            ? IndicatorResult.success
            : IndicatorResult.noMore);
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishLoad(IndicatorResult.fail);
      }
    });
  }

  void searchPendingOrder(String value) {
    state.searchContent = value;
    onRefresh();
  }


  void toDeleteOrder(int? id) {
    Get.dialog(
      Warning(
        cancel: '取消',
        confirm: '确定',
        content: '确认删除此挂单吗？删除后不可恢复！',
        onCancel: () => {},//Get.back(),
        onConfirm: () {
          Http().network(Method.delete, OrderApi.pending_order_delete, queryParameters: {
            'salesOrderDraftId': id,
          }).then((result) {
            if (result.success) {
              onRefresh();
              Toast.show('删除成功');
             // Get.back();
            } else {
              Toast.show(result.m.toString());
            }
          });
        },
      ),
      barrierDismissible: false,
    );
  }
}
