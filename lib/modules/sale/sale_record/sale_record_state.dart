import 'package:easy_refresh/easy_refresh.dart';
import 'package:ledger/entity/order/order_dto.dart';
import 'package:ledger/entity/user/user_base_dto.dart';
import 'package:ledger/enum/order_type.dart';

class SaleRecordState {
  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  int currentPage = 1;

  int initialIndex = 0;

  bool? hasMore;

  DateTime startDate = DateTime.now().subtract(Duration(days: 7));
  DateTime endDate = DateTime.now();

  //收款状态
  int? orderStatus;

  List<OrderDTO>? list;

  int? id;

  List<UserBaseDTO>? employeeList;

  OrderType orderType = OrderType.SALE;
  List<int> typeList = [OrderType.SALE.value,OrderType.SALE_RETURN.value];

  //已作废单据选择
  int? invalid = 0;

  String? searchContent = '';

  //业务员选择
  List<int>? selectEmployeeIdList;

  int? get itemCount => employeeList?.length; //筛选里chip的数量

  SaleRecordState();
}
