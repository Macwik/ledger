import 'package:easy_refresh/easy_refresh.dart';
import 'package:ledger/entity/repayment/repayment_dto.dart';

class RepaymentRecordState {
  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  int currentPage = 1;
  bool? hasMore;
  List<RepaymentDTO>? items;

  DateTime startDate = DateTime.now().subtract(Duration(days: 7));
  DateTime endDate = DateTime.now();

  int initialIndex = 0;

  String? dateRange;

  //已作废单据选择
  int? invalid =0 ;

  String? searchContent ='';

  int? customType;

  RepaymentRecordState() {
    ///Initialize variables
  }
}
