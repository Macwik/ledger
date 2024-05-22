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
          'name':state.supplierName,
          'invalid':  state.invalid,// 0 启用 | 1 未启用 | null 全部
        }).then((result) {
      if (result.success) {
        state.productOwnerList.clear();
        state.productOwnerList.addAll(result.d!);
        update(['product_owner_list',]);
      }
    });
  }

  //筛选里清空条件
  void clearCondition() {
    state.invalid = 0;
    update(['switch',]);
  }

  //筛选里‘确定’
  void confirmCondition() {
    _queryProductOwnerList();
    Get.back();
  }

  void searchCustom(String searchValue) {
    state.supplierName = searchValue;
    _queryProductOwnerList();
  }

  void addProductOwner() {
    Get.dialog(AlertDialog(
      title: Text('新增货主',
          style: TextStyle(fontSize: 40.sp,
              fontWeight: FontWeight.w600)),
      content:SingleChildScrollView(
          child:Column(
            children: [
              Row(
                children: [
                  Text('手机号'),
                  Expanded(child: TextFormField(
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
                  ))

                ],
              ),
              Row(
                children: [
                  Text('备注'),
                  Expanded(child:TextFormField(
                      controller: state.productOwnerRemarkController,
                      maxLength: 8,
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: '请输入备注',
                        hintStyle: TextStyle(fontSize: 32.sp),
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.name
                  ))
                ],
              )
            ],
          )
          ),
      actions: [
        TextButton(

          onPressed: () {
            Get.back();
            state.productOwnerNameController.clear();
            state.productOwnerRemarkController.clear();
          },
          child: Text('取消',style: TextStyle(color: Colours.text_666),),
        ),
        TextButton(onPressed:() async {
          final result = await Http().network<void>(
              Method.post, ProductOwnerApi.add_product_owner,
              data: {
                'phone': state.productOwnerNameController.text,
                'remark':state.productOwnerRemarkController.text
              });
          if (result.success) {
            _queryProductOwnerList();
            Get.back();
            state.productOwnerNameController.clear();
            state.productOwnerRemarkController.clear();
            Toast.show('添加成功');
          } else {
            Toast.show(result.m.toString());
          }
        } , child: Text('确定'),),
      ],
    ));
  }

  void toSelectProductOwner(SupplierDTO supplierDTO) {
    if(supplierDTO.invalid == 1){
        Toast.show('停用客户不可选');
    }else{
      Get.back(result:supplierDTO);
      _queryProductOwnerList();
    }

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
              _queryProductOwnerList();
              Get.back();
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

  Future<void> addProductOwnerRemark(int? id) async {
  await  Get.dialog(AlertDialog(
      title: Text('填写备注',
          style: TextStyle(fontSize: 40.sp,
              fontWeight: FontWeight.w600)),
      content:SingleChildScrollView(
          child:TextFormField(
              controller: state.productOwnerRemarkController,
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
            state.productOwnerRemarkController.clear();
          },
          child: Text('取消',style: TextStyle(color: Colours.text_666),),
        ),
        TextButton(onPressed:() async {
          final result = await Http().network<void>(
              Method.post, ProductOwnerApi.refresh_product_owner,
              data: {
               'id':id,
                'remark':state.productOwnerRemarkController.text,
              });
          if (result.success) {
            state.productOwnerRemarkController.clear();
            _queryProductOwnerList();
            Get.back();
            Get.back();
            Toast.show('添加成功');
          } else {
            Toast.show(result.m.toString());
          }
        },
          child: Text('确定'),),
      ],
    ));
  }

  showBottomSheet(BuildContext context, SupplierDTO supplierDTO) {
    List<Widget> actions = [];
    if (supplierDTO.used == 0) {
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
               addProductOwnerRemark(supplierDTO.id);
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
                _queryProductOwnerList();
                Get.back();
                Toast.show('成功停用');
              } else {
                Toast.show(result.m.toString());
              }
            });
          } else {
            Http().network(Method.put, ProductOwnerApi.enable_product_owner, queryParameters: {
              'supplierId': supplierDTO?.id,
            }).then((result) {
              if (result.success) {
                _queryProductOwnerList();
                Get.back();
                Toast.show('成功启用');
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
