import 'package:easy_refresh/easy_refresh.dart';
import 'package:ledger/entity/order/order_dto.dart';
import 'package:ledger/entity/user/user_base_dto.dart';

class BindingSaleBillState {
  DateTime startDate = DateTime.now().subtract(Duration(days: 90));
  DateTime endDate = DateTime.now();


  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  int currentPage = 1;

  bool? hasMore;

  List<OrderDTO>? items;

  OrderDTO? orderDTO;

  List<UserBaseDTO>? employeeList;

  //业务员选择
  List<int>? selectEmployeeIdList;

  int? get itemCount => employeeList?.length; //筛选里chip的数量

  //订单状态
  int? orderStatus;

  BindingSaleBillState() {
    ///Initialize variables
  }

  String? searchContent = '';

}
