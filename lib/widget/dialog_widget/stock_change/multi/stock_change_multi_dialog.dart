import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/entity/product/product_stock_adjust_request.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/dialog_widget/stock_change/multi/stock_change_multi_dialog_binding.dart';
import 'package:ledger/widget/dialog_widget/stock_change/multi/stock_change_multi_dialog_controller.dart';

class StockChangeMultiDialog extends StatelessWidget {
  final formKey = GlobalKey<FormBuilderState>();

  final ProductDTO productDTO;
  late final StockChangeMultiDialogController controller;
  final Function(ProductStockAdjustRequest? result) onClick;

  StockChangeMultiDialog({
    required this.productDTO,
    required this.onClick}){
    StockChangeMultiDialogBinding().dependencies();
    controller = Get.find<StockChangeMultiDialogController>();
    controller.slaveStockController.text = DecimalUtil.formatDecimalDefault(productDTO.unitDetailDTO?.slaveStock
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.initState();
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
                        '库存数量',
                        style: TextStyle(
                          fontSize: 32.sp,
                          color: Colours.text_666,
                        ),
                      ),
                      Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                '${DecimalUtil.formatDecimalNumber(
                                  productDTO.unitDetailDTO?.slaveStock,
                                )}'
                                '${productDTO.unitDetailDTO?.slaveUnitName} | '
                                '${DecimalUtil.formatDecimalNumber(productDTO.unitDetailDTO?.masterStock)}'
                                '${productDTO.unitDetailDTO?.masterUnitName}',
                                style: TextStyle(
                                  fontSize: 32.sp,
                                  color: Colours.text_666,
                                ),
                              ))),
                    ],
                  ),
                  Container(
                    color: Colours.divider,
                    height: 2.w,
                    margin: EdgeInsets.only(top: 24.w, bottom: 8.w),
                    width: double.infinity,
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        '实际数量',
                        style: TextStyle(
                          fontSize: 32.sp,
                          color: Colours.text_666,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          onChanged: (value){controller.masterNum = value;
                            controller.update(['master_profit_and_loss']);
                            },
                          controller: controller.slaveStockController,
                          autofocus: true,
                          onTap: () {
                            controller.updateSlaveStock(productDTO.unitDetailDTO);
                            controller.slaveStockController.selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: controller.slaveStockController.value.text.length);
                          },
                          textAlign: TextAlign.center,
                          maxLength: 10,
                          decoration: InputDecoration(
                              counterText: '',
                              hintText: '0.00',
                              border: InputBorder.none),
                          style: TextStyle(fontSize: 32.sp),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            var slaveStockStr =
                                controller.slaveStockController.text;
                            if (slaveStockStr.isEmpty) {
                              return '请输入商品辅单位数量';
                            }
                            Decimal? slaveStock =
                                Decimal.tryParse(slaveStockStr);
                            if (slaveStock == null ||
                                (slaveStock < Decimal.zero)) {
                              return '盘点后商品数量不能小于0';
                            }
                            return null;
                          },
                        ),
                      ),
                      Text(
                        productDTO.unitDetailDTO?.slaveUnitName ?? '',
                        style: TextStyle(
                          fontSize: 32.sp,
                          color: Colours.text_666,
                        ),
                      )
                    ],
                  ),
                  Container(
                    color: Colours.divider,
                    height: 2.w,
                    width: double.infinity,
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        '实际数量',
                        style: TextStyle(
                          fontSize: 32.sp,
                          color: Colours.text_666,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          onTap: () {
                            controller.updateMasterStock(productDTO.unitDetailDTO);
                            controller.masterStockController.selection =
                                TextSelection(
                                    baseOffset: 0,
                                    extentOffset: controller.masterStockController.value.text.length);
                          },
                          controller: controller.masterStockController,
                          textAlign: TextAlign.center,
                          maxLength: 10,
                          style: TextStyle(fontSize: 32.sp),
                          decoration: InputDecoration(
                              counterText: '',
                              hintText: '0.00',
                              border: InputBorder.none),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            var masterStockStr = controller
                                .masterStockController.text;
                            if (masterStockStr.isEmpty) {
                              return '请输入商品主单位数量';
                            }
                            Decimal? masterStock =
                                Decimal.tryParse(masterStockStr);
                            if (masterStock == null ||
                                (masterStock < Decimal.zero)) {
                              return '盘点后商品数量不能小于0';
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
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: 24.w),
                  //   padding: EdgeInsets.symmetric(vertical: 16.w),
                  //   child: Flex(
                  //     direction: Axis.horizontal,
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         '盈亏：',
                  //         style: TextStyle(
                  //           fontSize: 32.sp,
                  //           color: Colours.text_666,
                  //         ),
                  //       ),
                  //       GetBuilder<StockChangeMultiDialogController>(
                  //           id: 'master_profit_and_loss',
                  //           builder: (_){
                  //         return Text(controller.widgetProfitAndLoss(productDTO),
                  //             style: TextStyle(
                  //               fontSize: 32.sp,
                  //               color: Colours.text_666,
                  //             ),
                  //           );
                  //       }),
                  //       Text(
                  //         productDTO.unitDetailDTO?.unitName ?? '',
                  //         style: TextStyle(
                  //           fontSize: 32.sp,
                  //           color: Colours.text_666,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
    String? masterStock = controller.masterStockController.text;
    String? slaveStock = controller.slaveStockController.text;
    return ProductStockAdjustRequest(
        productId: productDTO.id,
        productName: productDTO.productName,
        masterUnitName: productDTO.unitDetailDTO?.masterUnitName,
        slaveUnitName: productDTO.unitDetailDTO?.slaveUnitName,
        unitType: productDTO.unitDetailDTO?.unitType,
        masterStock: Decimal.tryParse(masterStock),
        slaveStock: Decimal.tryParse(slaveStock));
  }
}
