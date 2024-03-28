import 'package:decimal/decimal.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/entity/repayment/custom_credit_dto.dart';

class ChooseRepaymentOrderState {

  int currentPage = 1;
  List<CustomCreditDTO>? items;

  DateTime startDate = DateTime.now().subtract(Duration(days: 180));
  DateTime endDate = DateTime.now();


  CustomDTO? customDTO;

  bool selectAll = false;

  List<CustomCreditDTO> selected = [];

  Decimal totalAmount = Decimal.zero;


  ChooseRepaymentOrderState() {
    ///Initialize variables
  }
}
