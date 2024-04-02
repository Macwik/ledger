import 'package:decimal/decimal.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/enum/order_type.dart';

class CustomRecordState {

  int customType = 0;
  String? customName ='';

  // 联系人总数
  String contactsCount = '';

  final double suspensionHeight = 40;

//按钮选项
  var selectedStore = 0;

  List<CustomDTO> customList = [];

  bool isSelectCustom = false;

  OrderType? orderType;

  int? totalCreditCustom = 0;

  Decimal? totalCreditAmount;

  //欠款情况
  int? debtStatus;

  //未启用客户选择
  int? invalid = 0;

  int? customId;

  CustomRecordState() {
    ///Initialize variables
  }

  //选择导入客户方式
  int? selectedOption ;
}
