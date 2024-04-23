import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/payment_api.dart';
import 'package:ledger/entity/payment/payment_method_dto.dart';
import 'package:ledger/enum/is_select.dart';
import 'package:ledger/res/export.dart';

import 'payment_manage_state.dart';

class PaymentManageController extends GetxController {
  final PaymentManageState state = PaymentManageState();


  Future<void> initState() async {
    var arguments = Get.arguments;
    if (arguments != null && arguments['isSelect'] != null) {
      state.select = arguments['isSelect'];
    }
    _queryPaymentList();
  }

  Future<void> _queryPaymentList() async {
    final result = await Http().network<List<PaymentMethodDTO>>(
        Method.get, PaymentApi.LEDGER_PAYMENT_METHOD_LIST);
    if (result.success) {
      state.paymentMethodDTOList = result.d!;
      update(['paymentDetail']);
    } else {
      Toast.show(result.m.toString());
    }
  }

  void toDeleteLedger(int? id) {
      Get.dialog(
        Warning(
          cancel: '取消',
          confirm: '确定',
          content: '确认删除此支付方式吗？',
          onCancel: () {},
          onConfirm: () {
            Loading.showDuration();
            Http().network(Method.delete, PaymentApi.DELETE_LEDGER_PAYMENT_METHOD,
                queryParameters: {
                  'id': id,
                }).then((result) {
              Loading.dismiss();
              if (result.success) {
                Toast.show('删除成功');
                _queryPaymentList();
              } else {
                Toast.show(result.m.toString());
              }
            });
          },
        ),
        barrierDismissible: false,
      );
  }

  void addPaymentMethod() {
    Get.dialog(AlertDialog(
      title: Text('新增支付方式',
          style: TextStyle(fontSize: 40.sp,
              fontWeight: FontWeight.w600)),
      content:SingleChildScrollView(
              child:TextFormField(
                  controller: state.paymentNameController,
                  maxLength: 8,
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: '请输入支付方式名称',
                    hintStyle: TextStyle(fontSize: 32.sp),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: '支付方式名称不能为空'),
                  ]),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.name
              )),
      actions: [
        TextButton(

          onPressed: () {
            Get.back();
            state.paymentNameController.clear();
          },
          child: Text('取消',style: TextStyle(color: Colours.text_666),),
        ),
        TextButton(onPressed:() async {
          final result = await Http().network<void>(
              Method.post, PaymentApi.ADD_LEDGER_PAYMENT_METHOD,
              data: {
                'name': state.paymentNameController.text,
                'icon':'payment_common'
              });
          if (result.success) {
            _queryPaymentList();
            Get.back();
            state.paymentNameController.clear();
            Toast.show('添加成功');
          } else {
            Toast.show(result.m.toString());
          }
        } , child: Text('确定'),),
      ],
    ));
  }

  void toSelect(bankDTO) {
    if(state.select == IsSelectType.TRUE){
      Get.back(result: bankDTO);
    }
  }
}
