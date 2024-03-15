import 'package:easy_refresh/easy_refresh.dart';
import 'package:ledger/entity/product/stock_change_record_dto.dart';
import 'package:ledger/entity/user/user_base_dto.dart';

class StockChangeRecordState {
  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  int currentPage = 1;
  bool? hasMore;
  List<StockChangeRecordDTO>? items;

  String? dateRange;
  //订单状态
  int? orderStatus;

  DateTime startDate = DateTime.now().subtract(Duration(days: 7));
  DateTime endDate = DateTime.now();

  List<UserBaseDTO>? employeeList;

  //业务员选择
  List<int>? selectEmployeeIdList ;

  String? searchContent ='';

  int? invalid;

  int? get itemCount => employeeList?.length; //筛选里chip的数量
}
