import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/entity/product/product_stock_adjust_request.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/dialog_widget/stock_change/stock_change_controller.dart';

class StockChangeMultiDialog extends StatelessWidget {
  final formKey = GlobalKey<FormBuilderState>();
  final StockChangeController stockChangeController =
      Get.put<StockChangeController>(StockChangeController());

  final ProductDTO productDTO;
  final Function(ProductStockAdjustRequest? result) onClick;

  StockChangeMultiDialog({required this.productDTO, required this.onClick});

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
                        '目前库存',
                        style: TextStyle(
                          fontSize: 26.sp,
                          color: Colors.black87,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          onTap: () => stockChangeController
                              .updateSlaveStock(productDTO.unitDetailDTO),
                          controller:
                              stockChangeController.slaveStockController,
                          textAlign: TextAlign.center,
                          maxLength: 10,
                          decoration: InputDecoration(
                              counterText: '',
                              hintText: '0.00',
                              border: UnderlineInputBorder()),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            var slaveStockStr =
                                stockChangeController.slaveStockController.text;
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
                          fontSize: 28.sp,
                          color: Colors.black87,
                        ),
                      )
                    ],
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        '目前库存',
                        style: TextStyle(
                          fontSize: 26.sp,
                          color: Colors.black87,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          onTap: () => stockChangeController
                              .updateMasterStock(productDTO.unitDetailDTO),
                          controller:
                              stockChangeController.masterStockController,
                          textAlign: TextAlign.center,
                          maxLength: 10,
                          decoration: InputDecoration(
                              counterText: '',
                              hintText: '0.00',
                              border: UnderlineInputBorder()),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            var masterStockStr = stockChangeController
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
    String? masterStock = stockChangeController.masterStockController.text;
    String? slaveStock = stockChangeController.slaveStockController.text;
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
