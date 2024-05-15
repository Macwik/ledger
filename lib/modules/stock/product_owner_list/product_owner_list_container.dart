import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/product_owner_api.dart';
import 'package:ledger/entity/productOwner/supplier_dto.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/loading.dart';
import 'package:ledger/widget/warning.dart';

import 'product_owner_list_state.dart';

class ProductOwnerListContainer extends GetxController {
  final ProductOwnerListState state = ProductOwnerListState();

  Future<void> initState() async {
    _queryProductOwnerList();
  }


  _queryProductOwnerList() async {
    await Http().network<List<SupplierDTO>>(Method.post, ProductOwnerApi.get_product_owner,
        queryParameters: {
          'invalid':null
          //state.isSelectSupplier == true ? 0 : null,// 0 启用 | 1 未启用 | null 全部
        }).then((result) {
      if (result.success) {
        state.productOwnerList.clear();
        state.productOwnerList.addAll(result.d!);
        update(['product_owner_list',]);
      }
    });
  }

  void addProductOwner() {
    Get.dialog(AlertDialog(
      title: Text('新增货主',
          style: TextStyle(fontSize: 40.sp,
              fontWeight: FontWeight.w600)),
      content:SingleChildScrollView(
          child:TextFormField(
              controller: state.productOwnerNameController,
              maxLength: 11,
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
            state.productOwnerNameController.clear();
          },
          child: Text('取消',style: TextStyle(color: Colours.text_666),),
        ),
        TextButton(onPressed:() async {
          final result = await Http().network<void>(
              Method.post, ProductOwnerApi.add_product_owner,
              data: {'phone': state.productOwnerNameController.text});
          if (result.success) {
            _queryProductOwnerList();
            state.productOwnerNameController.clear();
            Get.back();
            Toast.show('添加成功');
          } else {
            Toast.show(result.m.toString());
          }
        } , child: Text('确定'),),
      ],
    ));
  }

  void toSelectProductOwner(SupplierDTO supplierDTO) {
    Get.back(result:supplierDTO);
    _queryProductOwnerList();
  }

 void toDeleteProductOwner(int? id) {
    Get.dialog(
      Warning(
        cancel: '取消',
        confirm: '确定',
        content: '确认删除此货主吗？',
        onCancel: () {},
        onConfirm: () {
          Loading.showDuration();
          Http().network(Method.delete, ProductOwnerApi.delete_product_owner,
              queryParameters: {
                 'supplierId': id,
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
            state.productOwnerNameController.clear();
          },
          child: Text('取消',style: TextStyle(color: Colours.text_666),),
        ),
        TextButton(onPressed:() async {
          final result = await Http().network<void>(//ToDO 需要一个更新的接口
              Method.post, ProductOwnerApi.add_product_owner,
              data: {
                // 'name': state.paymentNameController.text,
                // 'icon':'payment_common'
              });
          if (result.success) {
            // _queryPaymentList();
            Get.back();
            state.productOwnerNameController.clear();
            Toast.show('添加成功');
          } else {
            Toast.show(result.m.toString());
          }
        } , child: Text('确定'),),
      ],
    ));
  }

  showBottomSheet(BuildContext context, SupplierDTO supplierDTO) {
    List<Widget> actions = [];
    if (supplierDTO.invalid == 0) {
      actions.add(CupertinoActionSheetAction(
        onPressed: () {
          toDeleteProductOwner(supplierDTO.id);
        },
        child: Text('删除货主'),
        isDestructiveAction: true,
      ));
    }

    if (supplierDTO.invalid == 0) {
      actions.add(
         CupertinoActionSheetAction(
             onPressed: () {
               addProductOwnerRemark();
             },
            child: Text('添加备注')),
      );
    }

    actions.add( CupertinoActionSheetAction(
          onPressed: () {
            toInvalidCustom(supplierDTO);
          },
          child: Text(supplierDTO.invalid == 1
              ? '启用货主'
              : '停用货主'),
        ));

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: actions,
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
            },
            child: Text('取消'),
          ),
        );
      },
    );
  }


  //停用启用货主
  void toInvalidCustom(SupplierDTO? supplierDTO) {
    Get.dialog(
      Warning(
        cancel: '取消',
        confirm: '确定',
        content: supplierDTO?.invalid == 0
            ?  '确定停用此货主吗？'
            :  '确定启用此货主吗？',
        onCancel: () => Get.back(),
        onConfirm: () {
          if (supplierDTO?.invalid == 0) {
            Http().network(Method.put, ProductOwnerApi.invalid_product_owner, queryParameters: {
              'supplierId': supplierDTO?.id,
            }).then((result) {
              if (result.success) {
                Toast.show('成功停用');
                _queryProductOwnerList();
                Get.back();
              } else {
                Toast.show(result.m.toString());
              }
            });
          } else {
            Http().network(Method.put, ProductOwnerApi.enable_product_owner, queryParameters: {
              'supplierId': supplierDTO?.id,
            }).then((result) {
              if (result.success) {
                Toast.show('成功启用');
                _queryProductOwnerList();
                Get.back();
              } else {
                Toast.show(result.m.toString());
              }
            });
          }
        },
      ),
      barrierDismissible: false,
    );
  }
}
