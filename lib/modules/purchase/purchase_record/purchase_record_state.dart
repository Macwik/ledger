import 'package:decimal/decimal.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:ledger/entity/order/order_dto.dart';
import 'package:ledger/entity/user/user_base_dto.dart';
import 'package:ledger/enum/order_type.dart';

class PurchaseRecordState {
  PurchaseRecordState() {
    ///Initialize variables
  }
  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  bool? hasMore;

  int currentPage = 1;

  DateTime startDate = DateTime.now().subtract(Duration(days: 90));
  DateTime endDate = DateTime.now();

  List<UserBaseDTO>? employeeList;

  //业务员选择
  List<int>? selectEmployeeIdList;

  int? get itemCount => employeeList?.length; //筛选里chip的数量

  //收款状态
  int? orderStatus;

  //已作废单据选择
  int? invalid = 0;

  OrderType? orderType ;

  int index = 0;

  List<OrderDTO>? list;

  String? searchContent = '';

  Decimal? totalNumber;

  List<OrderType> orderTypeList = [];

}
