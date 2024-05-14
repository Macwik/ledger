import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/payment_api.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/loading.dart';
import 'package:ledger/widget/warning.dart';

import 'product_owner_list_state.dart';

class ProductOwnerListContainer extends GetxController {
  final ProductOwnerListState state = ProductOwnerListState();

  void addProductOwner() {
    Get.dialog(AlertDialog(
      title: Text('新增货主',
          style: TextStyle(fontSize: 40.sp,
              fontWeight: FontWeight.w600)),
      content:SingleChildScrollView(
          child:TextFormField(
              controller: state.productOwnerNameController,
              maxLength: 8,
              decoration: InputDecoration(
                counterText: '',
                hintText: '请输入货主手机号',
                hintStyle: TextStyle(fontSize: 32.sp),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: '货主手机号不能为空'),
              ]),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.name
          )),
      actions: [
        TextButton(

          onPressed: () {
            Get.back();
          },
          child: Text('取消',style: TextStyle(color: Colours.text_666),),
        ),
        TextButton(onPressed:() async {
          final result = await Http().network<void>(//ToDo api需要修改
              Method.post, PaymentApi.ADD_LEDGER_PAYMENT_METHOD,
              data: {
                // 'name': state.paymentNameController.text,
                // 'icon':'payment_common'
              });
          ///ToDo 需要判断下该供应商，是否注册账号
          if (true) {
            Get.defaultDialog(
                title: '该供应商未注册“货主鲜生”', // 设置标题为null，即不显示标题
                middleText: '该供应商用此手机号注册登录后才能看到账目 ',
                onConfirm: () {
                  Get.back();
                });
          }
          if (result.success) {
           // _queryPaymentList();
            Get.back();
            Toast.show('添加成功');
          } else {
            Toast.show(result.m.toString());
          }
        } , child: Text('确定'),),
      ],
    ));
  }

  void toSelectProductOwner() {
    Get.back;
      //(result: );
    // _queryPaymentList();
  }

 void toDeleteProductOwner() {
    Get.dialog(
      Warning(
        cancel: '取消',
        confirm: '确定',
        content: '确认删除此货主吗？',
        onCancel: () {},
        onConfirm: () {
          Loading.showDuration();//ToDo 如下的API需要修改
          Http().network(Method.delete, PaymentApi.DELETE_LEDGER_PAYMENT_METHOD,
              queryParameters: {
                // ToDO  'id': id,
              }).then((result) {
            Loading.dismiss();
            if (result.success) {
              Toast.show('删除成功');
            } else {
              Toast.show(result.m.toString());
            }
          });
        },
      ),
      barrierDismissible: false,
    );
  }

  void addProductOwnerRemark() {
    Get.dialog(AlertDialog(
      title: Text('填写备注',
          style: TextStyle(fontSize: 40.sp,
              fontWeight: FontWeight.w600)),
      content:SingleChildScrollView(
          child:TextFormField(
              controller: state.productOwnerNameController,
              maxLength: 8,
              decoration: InputDecoration(
                counterText: '',
                hintText: '请输入备注内容',
                hintStyle: TextStyle(fontSize: 32.sp),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: '备注内容不能为空'),
              ]),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.name
          )),
      actions: [
        TextButton(

          onPressed: () {
            Get.back();
          },
          child: Text('取消',style: TextStyle(color: Colours.text_666),),
        ),
        TextButton(onPressed:() async {
          final result = await Http().network<void>(//ToDo api需要修改
              Method.post, PaymentApi.ADD_LEDGER_PAYMENT_METHOD,
              data: {
                // 'name': state.paymentNameController.text,
                // 'icon':'payment_common'
              });
          if (result.success) {
            // _queryPaymentList();
            Get.back();
            Toast.show('添加成功');
          } else {
            Toast.show(result.m.toString());
          }
        } , child: Text('确定'),),
      ],
    ));
  }
}
