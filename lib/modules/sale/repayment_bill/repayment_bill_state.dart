import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ledger/entity/costIncome/order_pay_request.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/entity/payment/payment_method_dto.dart';
import 'package:ledger/entity/repayment/custom_credit_dto.dart';
import 'package:ledger/entity/setting/sales_line_dto.dart';
import 'package:ledger/enum/is_select.dart';

class RepaymentBillState {
  final formKey = GlobalKey<FormBuilderState>();

  PaymentMethodDTO? paymentMethodDTO;

  //客户名称
  CustomDTO? customDTO;

  int? customType;

  int? customId;

  Decimal repaymentTotalAmount = Decimal.zero;

  TextEditingController repaymentController = TextEditingController();

  TextEditingController discountController = TextEditingController();

  /// 收款金额
  Decimal? repaymentAmount;

  //选择收款单
  List<CustomCreditDTO>? customCreditDTO;

  List<OrderPayRequest>? payRequest;

  DateTime date = DateTime.now();

  RepaymentBillState() {
    ///Initialize variables
  }

  IsSelectType isSelect = IsSelectType.FALSE;

  TextEditingController remarkController = TextEditingController();

  int? index;

  SalesLineDTO? salesLineDTO;

}
