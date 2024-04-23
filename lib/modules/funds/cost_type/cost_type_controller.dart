import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/cost_income_api.dart';
import 'package:ledger/entity/costIncome/cost_income_label_type_dto.dart';
import 'package:ledger/enum/cost_order_type.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/warning.dart';

import 'cost_type_state.dart';

class CostTypeController extends GetxController {
  final CostTypeState state = CostTypeState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if (arguments != null && arguments['costOrderType'] != null) {
      state.costOrderType = arguments['costOrderType'];
    }
    queryData();
    update(['purchase_cost', 'daily_cost']);
  }

  void queryData() {
    Http().network<List<CostIncomeLabelTypeDTO>>(
        Method.get, CostIncomeApi.get_cost_type,
        queryParameters: {'type': 0}).then((result) {
      if (result.success) {
        state.costLabelTypeDTO = result.d;
        update(['purchase_cost']);
      } else {
        Toast.show(result.m.toString());
      }
    });
    Http().network<List<CostIncomeLabelTypeDTO>>(
        Method.get, CostIncomeApi.get_cost_type,
        queryParameters: {'type': 1}).then((result) {
      if (result.success) {
        state.dailyLabelTypeDTO = result.d;
        update(['daily_cost']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  Future toAddCostType() async {
    Get.dialog(AlertDialog(
      title:  Text('新增费用名称',
          style: TextStyle(fontSize: 40.sp,
              fontWeight: FontWeight.w600)) ,
      content:FormBuilder(
          key: state.formKey,
          child: TextFormField(
            controller: state.costNameController,
            decoration: InputDecoration(
              counterText: '',
              hintText: '请输入费用名称',
              hintStyle: TextStyle(
                color: Colours.text_ccc,
                fontSize: 32.sp
              ),
            ),
            keyboardType: TextInputType.name,
            maxLength: 10,
            validator: FormBuilderValidators.required(
                errorText: '费用名称不能为空'),
          )),
        actions: [
          TextButton(
            onPressed: (){
              Get.back();
              state.costNameController.clear();
            },
            child:  Text('取消',
              style: TextStyle(
                  color: Colours.text_666
              ),),),
          TextButton(
            child: Text('确定'),
            onPressed: ()  async {
              (state.formKey.currentState?.saveAndValidate() ?? false)
                  ? addCostType()
                  :Null;
            },
          ),
        ]
    ));
  }

  void addCostType() async {
      final result = await Http()
          .network<void>(Method.post, CostIncomeApi.add_cost_type, data: {
        'type':CostOrderType.COST.value,
        'labelName': state.costNameController.text,
      });
      if (result.success) {
        Toast.show('添加成功');
        Get.back();
        state.costNameController.clear();
        queryData();
      } else {
        Toast.show(result.m.toString());
      }
 }

  Future toAddIncomeType() async {
    Get.dialog(AlertDialog(
      title:  Text('新增收入名称',
          style: TextStyle(fontSize: 40.sp,
              fontWeight: FontWeight.w600)),
      content:FormBuilder(
          key: state.formKey,
          child: TextFormField(
        controller: state.incomeNameController,
        decoration: InputDecoration(
          counterText: '',
          hintText: '请输入收入名称',
          hintStyle: TextStyle(
            color: Colours.text_ccc,
              fontSize: 32.sp
          ),
        ),
        keyboardType: TextInputType.name,
        maxLength: 10,
        validator: FormBuilderValidators.required(
            errorText: '收入名称不能为空'),
      )),
        actions: [
          TextButton(
            onPressed: (){
              Get.back();
              state.incomeNameController.clear();
            },
            child:  Text('取消',
              style: TextStyle(
                  color: Colours.text_666
              ),),),
          TextButton(
            child: Text('确定'),
            onPressed: ()  async {
              (state.formKey.currentState?.saveAndValidate() ?? false)
                  ? addIncomeType()
                  :Null;
            },
          ),
        ]
    ));
  }

  void addIncomeType() async {
    final result = await Http()
        .network<void>(Method.post, CostIncomeApi.add_cost_type, data: {
      'type': CostOrderType.INCOME.value,
      'labelName': state.incomeNameController.text,
    });
    if (result.success) {
      Toast.show('添加成功');
      Get.back();
      state.incomeNameController.clear();
      queryData();
      //return true;
    } else {
      Toast.show(result.m.toString());
      //return false;
    }
 }

  void toDeleteOrder(int id, int type) {
    Get.dialog(
      Warning(
        cancel: '取消',
        confirm: '确定',
        content: '确认删除此项吗？',
        onCancel: () {},
        onConfirm: () {
          Http().network(Method.delete, CostIncomeApi.delete_cost_type,
              queryParameters: {
                'id': id,
                'type': type,
              }).then((result) {
            if (result.success) {
              Toast.show('删除成功');
              queryData();
            } else {
              Toast.show(result.m.toString());
            }
          });
        },
      ),
      barrierDismissible: false,
    );
  }
}
