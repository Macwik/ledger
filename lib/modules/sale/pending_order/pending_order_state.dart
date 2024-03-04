import 'package:easy_refresh/easy_refresh.dart';
import 'package:ledger/entity/draft/order_draft_dto.dart';

class PendingOrderState {
  PendingOrderState() {
    ///Initialize variables
  }
  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  int currentPage = 1;

  bool? hasMore;

  List<OrderDraftDTO>? list;

  String? searchContent = '';
}

