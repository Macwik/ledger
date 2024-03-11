import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ledger/entity/payment/payment_method_dto.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/entity/remittance/remittance_dto.dart';

class RemittanceState {
  final formKey = GlobalKey<FormBuilderState>();

  RemittanceDTO ? remittanceDTO ;

  ProductDTO? productDTO;

  PaymentMethodDTO? paymentMethodDTO;

  DateTime date = DateTime.now();

  TextEditingController receiverController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

}

