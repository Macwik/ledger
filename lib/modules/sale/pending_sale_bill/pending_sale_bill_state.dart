import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/entity/draft/order_draft_detail_dto.dart';
import 'package:ledger/entity/payment/order_pay_dialog_result.dart';
import 'package:ledger/entity/payment/payment_method_dto.dart';
import 'package:ledger/entity/product/product_shopping_car_dto.dart';
import 'package:ledger/store/store_controller.dart';

class PendingSaleBillState {
  PendingSaleBillState() {
    ///Initialize variables
  }
  final formKey = GlobalKey<FormBuilderState>();

  DateTime date = DateTime.now();

  CustomDTO? customDTO;

  OrderDraftDetailDTO? orderDraftDetailDTO;

  List<ProductShoppingCarDTO> shoppingCarList =[];

  Decimal totalAmount = Decimal.zero;

  bool visible = false;

  List<PaymentMethodDTO>? paymentMethods;

  TextEditingController remarkTextEditingController = TextEditingController();

  OrderPayDialogResult? orderPayDialogResult;

  String? ledgerName = StoreController.to.getUser()?.activeLedger?.ledgerName;

  int? draftId;

  int? pendingOrderNum = 0;

 // String? customName;
}
