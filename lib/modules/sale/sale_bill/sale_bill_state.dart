import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/entity/order/order_payment_dto.dart';
import 'package:ledger/entity/payment/order_pay_dialog_result.dart';
import 'package:ledger/entity/payment/payment_method_dto.dart';
import 'package:ledger/entity/product/product_shopping_car_dto.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/store/store_controller.dart';

class SaleBillState {
  final formKey = GlobalKey<FormBuilderState>();

  String? ledgerName = StoreController.to.getUser()?.activeLedger?.ledgerName;

  int ? pendingOrderNum = 0;

  List<PaymentMethodDTO>? paymentMethods;

  bool checked = true;

  OrderType orderType = OrderType.PURCHASE;

  DateTime date = DateTime.now();

  CustomDTO? customDTO;

  OrderPayDialogResult? orderPayDialogResult;

  List<ProductShoppingCarDTO> shoppingCarList =[];

  Decimal totalAmount = Decimal.zero;

  List<OrderPaymentDTO>? orderPayRequest;

  TextEditingController textEditingController = TextEditingController();

  SaleBillState();

  bool visible = false;

}
