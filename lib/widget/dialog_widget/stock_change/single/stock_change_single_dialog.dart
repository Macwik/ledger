import 'package:decimal/decimal.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/entity/product/product_stock_adjust_request.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/dialog_widget/stock_change/single/stock_change_single_dialog_binding.dart';
import 'package:ledger/widget/dialog_widget/stock_change/single/stock_change_single_dialog_controller.dart';

class StockChangeSingleDialog extends StatelessWidget {
  final formKey = GlobalKey<FormBuilderState>();

  final ProductDTO productDTO;
  late final StockChangeSingleDialogController controller;
  final bool Function(ProductStockAdjustRequest? result) onClick;

  StockChangeSingleDialog({
    required this.productDTO,
    required this.onClick}) {
    StockChangeSingleDialogBinding().dependencies();
    controller = Get.find<StockChangeSingleDialogController>();
    controller.stockChangeController.text = DecimalUtil.formatDecimalNumber(productDTO.unitDetailDTO?.stock);
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: formKey,
        child: Column(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        '库存数量',
                        style: TextStyle(
                          fontSize: 32.sp,
                          color: Colors.black87,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                              alignment: Alignment.center,
                              child: Text( DecimalUtil.formatDecimalNumber(productDTO.unitDetailDTO?.stock),
                                style: TextStyle(
                                  fontSize: 32.sp,
                                  color: Colors.black87,
                                ),))
                      ),
                      Text(
                        productDTO.unitDetailDTO?.unitName ?? '',
                        style: TextStyle(
                          fontSize: 32.sp,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colours.divider,
                    height: 2.w,
                    margin: EdgeInsets.only(top: 24.w,bottom: 8.w),
                    width: double.infinity,
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        '实际数量',
                        style: TextStyle(
                          fontSize: 32.sp,
                          color: Colors.black87,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          onChanged: (value){controller.update(['profit_and_loss']);},
                          controller:  controller.stockChangeController,
                          autofocus: true,
                          onTap: () {
                            controller.stockChangeController.selection = TextSelection(baseOffset: 0, extentOffset: controller.stockChangeController.value.text.length);
                          },
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: '请填写',
                            border: InputBorder.none
                          ),
                          style: TextStyle(
                              fontSize: 32.sp
                          ),
                          textAlign: TextAlign.center,
                          maxLength: 10,
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
                          fontSize: 32.sp,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration:BoxDecoration(
                      color: Colours.divider,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    height: 8.w,
                    width: double.infinity,
                  ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: 24.w),
                  //   padding: EdgeInsets.symmetric(vertical: 16.w),
                  //   child:  Flex(
                  //     direction: Axis.horizontal,
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         '盈亏：',
                  //         style: TextStyle(
                  //           fontSize: 32.sp,
                  //           color: Colors.black87,
                  //         ),
                  //       ),
                  //       GetBuilder<StockChangeSingleDialogController>(
                  //           id: 'profit_and_loss',
                  //           builder: (_){
                  //         return  Text(widgetProfitAndLoss(),
                  //           style: TextStyle(
                  //             fontSize: 32.sp,
                  //             color: Colors.black87,
                  //           ),
                  //         );
                  //       }),
                  //       Text(
                  //         productDTO.unitDetailDTO?.unitName ?? '',
                  //         style: TextStyle(
                  //           fontSize: 32.sp,
                  //           color: Colors.black87,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
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

  ProductStockAdjustRequest buildProductStockAdjustRequest() {
    return ProductStockAdjustRequest(
        productId: productDTO.id,
        productName: productDTO.productName,
        unitName: productDTO.unitDetailDTO?.unitName,
        unitType: productDTO.unitDetailDTO?.unitType,
        stock: Decimal.tryParse(controller.stockChangeController.text));
  }

  // String widgetProfitAndLoss() {
  //   Decimal? productNum = productDTO.unitDetailDTO?.stock;
  //   if((productDTO.unitDetailDTO==null)||(productDTO.unitDetailDTO?.stock == null)){
  //     productNum = Decimal.zero;
  //   }
  //   String? num = controller.stockChangeController.text;
  //   Decimal? numDec = Decimal.tryParse(num);
  //   return DecimalUtil.subtract((productNum??Decimal.zero),(numDec??Decimal.zero));
  // }
}
