import 'package:decimal/decimal.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/entity/product/product_stock_adjust_request.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/custom_textfield.dart';

class StockChangeSingleDialog extends StatelessWidget {
  final formKey = GlobalKey<FormBuilderState>();

  final ProductDTO productDTO;
  final bool Function(ProductStockAdjustRequest? result) onClick;

  StockChangeSingleDialog({required this.productDTO, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: formKey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 50.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        '目前库存',
                        style: TextStyle(
                          fontSize: 28.sp,
                          color: Colors.black87,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          name: 'stockChangeNum',
                          hintText: '0.00',
                          textAlign: TextAlign.center,
                          maxLength: 10,
                          border: UnderlineInputBorder(),
                          keyboardType: TextInputType.number,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: '库存调整数量不能为空'),
                            (value) {
                              var repaymentAmount = Decimal.tryParse(value!);
                              if (null == repaymentAmount) {
                                return '库存调整数量请输入数字';
                              } else if (repaymentAmount < Decimal.zero) {
                                return '库存调整数量不能小于0';
                              } else if (value.startsWith('0')) {
                                return null;
                              }
                              return null;
                            },
                          ]),
                        ),
                      ),
                      Text(
                        productDTO.unitDetailDTO?.unitName ?? '',
                        style: TextStyle(
                          fontSize: 28.sp,
                          color: Colors.black87,
                        ),
                      ),
                    ],
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
                        backgroundColor: Colors.white,
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
                          if (onClick(buildProductStockAdjustRequest())) {
                            Get.back(result: ProcessStatus.OK);
                          } else {
                            Toast.show('系统异常！');
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

  ProductStockAdjustRequest buildProductStockAdjustRequest() {
    String? value = formKey.currentState?.fields['stockChangeNum']?.value;
    return ProductStockAdjustRequest(
        productId: productDTO.id,
        productName: productDTO.productName,
        unitName: productDTO.unitDetailDTO?.unitName,
        unitType: productDTO.unitDetailDTO?.unitType,
        stock: Decimal.tryParse(value ?? '0'));
  }
}
