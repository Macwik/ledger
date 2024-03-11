import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ledger/entity/costIncome/cost_income_label_type_dto.dart';
import 'package:ledger/entity/order/order_detail_dto.dart';
import 'package:ledger/entity/order/order_dto.dart';
import 'package:ledger/entity/order/order_payment_dto.dart';
import 'package:ledger/entity/order/order_product_detail_dto.dart';
import 'package:ledger/entity/payment/payment_method_dto.dart';
import 'package:ledger/enum/cost_order_type.dart';

class CostBillState {
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController textEditingController = TextEditingController();

  CostIncomeLabelTypeDTO? costLabel;

  PaymentMethodDTO? bankDTO;

  //支付方式
  List<OrderPaymentDTO>? orderPayments;

 //选择日期
  DateTime date = DateTime.now();

  //关联采购单
  OrderDTO? orderDTO;

  OrderDetailDTO? orderDetailDTO;

  Set<OrderProductDetail>? bindingProduct;

  CostOrderType ? costOrderType;

  String? costName;

  //选择费用扣除地
  int? selectedOption ;

  CostBillState() {
    ///Initialize variables
  }

  TextEditingController amountController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
}
