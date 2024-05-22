import 'package:easy_refresh/easy_refresh.dart';
import 'package:ledger/entity/costIncome/cost_income_label_type_dto.dart';
import 'package:ledger/entity/costIncome/cost_income_order_dto.dart';
import 'package:ledger/entity/costIncome/external_order_count_dto.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/entity/user/user_base_dto.dart';

class CostRecordState {

  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  int currentPage = 1;
  bool? hasMore;

  List<CostIncomeOrderDTO>? items;

  String? dateRange;

  String? searchContent = '';

  var selectedStore = 0;

  //绑定货物
  int? bindProduct;

  //选择货物类型
  CostIncomeLabelTypeDTO? costLabel;

  //已作废单据选择
  int? invalid = 0;

  //未绑定货物选择
  //int? invalid = 0;

  //订单状态
  int? orderStatus;

  DateTime startDate = DateTime.now().subtract(Duration(days: 90));
  DateTime endDate = DateTime.now();

  List<UserBaseDTO>? employeeList;

  //业务员选择
  List<int>? selectEmployeeIdList ;

  int? get itemCount => employeeList?.length;

  int? index;

  ProductDTO?  productDTO;

  ExternalOrderCountDTO? externalOrderCountDTO;

}
