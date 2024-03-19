
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
import 'package:ledger/widget/dialog_widget/refund_dialog/refund_dialog_binding.dart';
import 'package:ledger/widget/dialog_widget/refund_dialog/refund_dialog_controller.dart';

class RefundDialog extends StatelessWidget {
  final formKey = GlobalKey<FormBuilderState>();

  final ProductDTO productDTO;
  late final RefundDialogController controller;
  final Function(ProductShoppingCarDTO result) onClick;

  RefundDialog({required this.productDTO, required this.onClick}) {
    RefundDialogBinding().dependencies();
    controller = Get.find<RefundDialogController>();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 50.w),
              child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        '退款金额',
                        style: TextStyle(
                          fontSize: 32.sp,
                          color: Colours.text_666,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: controller.refundAmountController,
                          textAlign: TextAlign.center,
                          maxLength: 10,
                          style: TextStyle(fontSize: 32.sp),
                          decoration: InputDecoration(
                              counterText: '',
                              hintText: '0.00',
                            ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            var amount = controller.refundAmountController.text;
                            if (amount.isEmpty) {
                              return '请输入退款金额';
                            }
                            Decimal? masterStock = Decimal.tryParse(amount);
                            if (masterStock == null ||
                                (masterStock < Decimal.zero)) {
                              return '金额不能小于0';
                            }
                            return null;
                          },
                        ),
                      ),
                      Text(
                       '元',
                        style: TextStyle(
                          fontSize: 32.sp,
                          color: Colours.text_666,
                        ),
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
                              if (onClick(buildProductShoppingCarDTO())) {
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


  ProductShoppingCarDTO buildProductShoppingCarDTO() {
    return ProductShoppingCarDTO(
        productId: productDTO.id,
        productName: productDTO.productName,
        productPlace: productDTO.productPlace,
        productStandard: productDTO.productStandard,
        unitDetailDTO: getUnitDetailDTO());
  }

  UnitDetailDTO? getUnitDetailDTO() {
    String totalAmount = controller.refundAmountController.text;
    return productDTO.unitDetailDTO?.copyWith(
        totalAmount: Decimal.tryParse(totalAmount));
  }
}