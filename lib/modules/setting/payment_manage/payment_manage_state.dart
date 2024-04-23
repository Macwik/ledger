import 'package:flutter/cupertino.dart';
import 'package:ledger/entity/payment/payment_method_dto.dart';
import 'package:ledger/enum/is_select.dart';

class PaymentManageState {
  PaymentManageState();

  List<PaymentMethodDTO>? paymentMethodDTOList;

  PaymentMethodDTO ? paymentMethodDTO;

  IsSelectType? select;

  TextEditingController paymentNameController = TextEditingController();
}
