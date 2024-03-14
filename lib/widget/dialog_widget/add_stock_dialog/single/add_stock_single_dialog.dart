import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/entity/product/product_shopping_car_dto.dart';
import 'package:ledger/entity/unit/unit_detail_dto.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/dialog_widget/add_stock_dialog/single/add_stock_single_dialog_binding.dart';
import 'package:ledger/widget/dialog_widget/add_stock_dialog/single/add_stock_single_dialog_controller.dart';

class AddStockSingleDialog extends StatelessWidget {
  final formKey = GlobalKey<FormBuilderState>();

  final ProductDTO productDTO;
  late final AddStockSingleDialogController controller;
  final Function(ProductShoppingCarDTO result) onClick;

  AddStockSingleDialog({required this.productDTO, required this.onClick}) {
    AddStockSingleDialogBinding().dependencies();
    controller = Get.find<AddStockSingleDialogController>();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 50.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        '入库数量',
                        style: TextStyle(
                          fontSize: 32.sp,
                          color: Colours.text_666,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: controller.stockController,
                          textAlign: TextAlign.center,
                          maxLength: 10,
                          style: TextStyle(fontSize: 32.sp),
                          decoration: InputDecoration(
                              counterText: '',
                              hintText: '0.00',
                              border: InputBorder.none),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            var stockStr = controller.stockController.text;
                            if (stockStr.isEmpty) {
                              return '请输入入库数量';
                            }
                            Decimal? masterStock = Decimal.tryParse(stockStr);
                            if (masterStock == null ||
                                (masterStock < Decimal.zero)) {
                              return '数量不能小于0';
                            }
                            return null;
                          },
                        ),
                      ),
                      Text(
                        productDTO.unitDetailDTO?.masterUnitName ?? '',
                        style: TextStyle(
                          fontSize: 32.sp,
                          color: Colours.text_666,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colours.divider,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    height: 8.w,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Container(
                    height: 100.w,
                    child: ElevatedButton(
                      onPressed: () => Get.back(result: ProcessStatus.FAIL),
                      child: Text(
                        '取消',
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: Colors.black87,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                    ),
                  )),
                  Expanded(
                      child: Container(
                    height: 100.w,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState
                                ?.saveAndValidate(focusOnInvalid: false) ??
                            false) {
                          if (onClick(buildProductAddStockRequest())) {
                            Get.back(result: ProcessStatus.OK);
                          } else {
                            Toast.show('保存失败，请重试');
                          }
                        }
                      },
                      child: Text(
                        '确定',
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colours.primary,
                      ),
                    ),
                  ))
                ],
              ),
            )
          ],
        ));
  }

  ProductShoppingCarDTO buildProductAddStockRequest() {
    return ProductShoppingCarDTO(
        productId: productDTO.id,
        productName: productDTO.productName,
        productPlace: productDTO.productPlace,
        productStandard: productDTO.productStandard,
        unitDetailDTO: getUnitDetailDTO());
  }

  UnitDetailDTO? getUnitDetailDTO() {
    String? stock = controller.stockController.text;
    return productDTO.unitDetailDTO?.copyWith(
        unitId: productDTO.unitDetailDTO?.unitId,
        stock: Decimal.tryParse(stock));
  }
}
