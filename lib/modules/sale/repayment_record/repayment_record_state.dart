import 'package:easy_refresh/easy_refresh.dart';
import 'package:ledger/entity/repayment/repayment_dto.dart';
import 'package:ledger/enum/custom_type.dart';

class RepaymentRecordState {
  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  int currentPage = 1;
  bool? hasMore;
  List<RepaymentDTO>? items;

  DateTime startDate = DateTime.now().subtract(Duration(days: 90));
  DateTime endDate = DateTime.now();

  int index = 0;

  String? dateRange;

  //已作废单据选择
  int? invalid =0 ;

  String? searchContent ='';

  CustomType? customType;

  List<CustomType> customTypeList = [];

  RepaymentRecordState() {
    ///Initialize variables
  }

}
