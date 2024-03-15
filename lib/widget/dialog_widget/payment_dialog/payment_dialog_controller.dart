import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/entity/payment/order_pay_dialog_result.dart';
import 'package:ledger/util/decimal_util.dart';

class PaymentDialogController extends GetxController {
  TextEditingController firstAmountController = TextEditingController();
  TextEditingController secondAmountController = TextEditingController();
  TextEditingController textEditingController = TextEditingController();



  Decimal discountAmount = Decimal.zero; //不赋值为零，下面判断时候，需要它必须存在，不好解决
  CustomDTO? customDTO;
  bool groupPayment = false;

  int? selectPayMethodOne; //支付方式一

  int? selectPayMethodTwo; //支付方式二

  OrderPayDialogResult? result;

  TextEditingController remarkTextEditing =TextEditingController();


  void creditInputUpdate(Decimal totalAmount, Decimal discountAmount) {
    String paymentMethodSecond = secondAmountController.text;
    Decimal paymentSecond =
        Decimal.tryParse(paymentMethodSecond) ?? Decimal.zero;
    String? paymentMethodFirst = firstAmountController.text;
    Decimal paymentFirst = Decimal.tryParse(paymentMethodFirst) ?? Decimal.zero;
    textEditingController.text = DecimalUtil.formatDecimalDefault(
        totalAmount - discountAmount - paymentFirst - paymentSecond);
  }

  void paymentTwoUpdate(Decimal totalAmount, Decimal discountAmount) {
    String paymentMethodSecond = firstAmountController.text;
    Decimal paymentSecond =
        Decimal.tryParse(paymentMethodSecond) ?? Decimal.zero;
    String? creditAmount = textEditingController.text;
    Decimal creditAmounts = Decimal.tryParse(creditAmount) ?? Decimal.zero;
    secondAmountController.text = DecimalUtil.formatDecimalDefault(
        totalAmount - discountAmount - paymentSecond - creditAmounts);
  }

  void paymentFirstUpdate(Decimal totalAmount, Decimal discountAmount) {
    String paymentMethodSecond = secondAmountController.text;
    Decimal paymentSecond =
        Decimal.tryParse(paymentMethodSecond) ?? Decimal.zero;
    String? creditAmount = textEditingController.text;
    Decimal creditAmounts = Decimal.tryParse(creditAmount) ?? Decimal.zero;
    firstAmountController.text = DecimalUtil.formatDecimalDefault(
        totalAmount - discountAmount - paymentSecond - creditAmounts);
  }


}
