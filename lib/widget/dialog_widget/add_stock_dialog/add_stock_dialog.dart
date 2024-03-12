import 'package:decimal/decimal.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/product/product_add_stock_car_dto.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/enum/unit_type.dart';
import 'package:ledger/generated/json/product_add_stock_car_dto.g.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';
import 'add_stock_dialog_binding.dart';
import 'add_stock_dialog_controller.dart';

class AddStockDialog extends StatelessWidget {
  final formKey = GlobalKey<FormBuilderState>();

  late final AddStockDialogController controller;
  final ProductDTO productDTO;
  final Function(ProductAddStockCarDTO result) onClick;

  AddStockDialog({required this.productDTO, required this.onClick}) {
    AddStockDialogBinding().dependencies();
    controller = Get.find<AddStockDialogController>();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: formKey,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 16.w),
                child: Center(
                  child: Text(
                    productDTO.productName ?? '',
                    style: TextStyle(
                        fontSize: 34.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 8.w, left: 8.w, bottom: 10.w),
                child: GetBuilder<AddStockDialogController>(
                    id: 'add_stock_unit',
                    init: controller,
                    global: false,
                    builder: (_) {
                      return Visibility(
                          visible: UnitType.SINGLE.value !=
                              productDTO.unitDetailDTO?.unitType,
                          child: Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 8.w),
                                child: Text(
                                  '单位',
                                  style: TextStyle(
                                    fontSize: 30.sp,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (false ==
                                          productDTO.unitDetailDTO
                                              ?.selectMasterUnit) {
                                        controller.masterController.text = '';
                                        controller.slaveController.text = '';
                                        productDTO.unitDetailDTO
                                            ?.selectMasterUnit = true;
                                        controller.update([]);
                                      }
                                    },
                                    child: Text(
                                      productDTO
                                              .unitDetailDTO?.masterUnitName ??
                                          '',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: productDTO.unitDetailDTO
                                                  ?.selectMasterUnit ??
                                              true
                                          ? Colors.white
                                          : Colours.text_333,
                                      backgroundColor: productDTO.unitDetailDTO
                                                  ?.selectMasterUnit ??
                                              true
                                          ? Colours.primary
                                          : Colors.white60,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(horizontal: 8.w),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (productDTO
                                            .unitDetailDTO?.selectMasterUnit ??
                                        true) {
                                      controller.masterController.text = '';
                                      controller.slaveController.text = '';
                                      productDTO.unitDetailDTO
                                          ?.selectMasterUnit = false;
                                      controller.update([]);
                                    }
                                  },
                                  child: Text(
                                    productDTO.unitDetailDTO?.slaveUnitName ??
                                        '',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: productDTO.unitDetailDTO
                                                ?.selectMasterUnit ??
                                            true
                                        ? Colours.text_333
                                        : Colors.white,
                                    backgroundColor: productDTO.unitDetailDTO
                                                ?.selectMasterUnit ??
                                            true
                                        ? Colors.white60
                                        : Colours.primary,
                                  ),
                                ),
                              ))
                            ],
                          ));
                    }),
              ),
              Container(
                padding: EdgeInsets.only(right: 40.w, left: 40.w, bottom: 32.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GetBuilder<AddStockDialogController>(
                        id: 'add_stock_master_number',
                        init: controller,
                        global: false,
                        builder: (_) {
                          return Visibility(
                              visible: isMasterUnitShow(),
                              child: Row(
                                children: [
                                  Text(
                                    '重量',
                                    style: TextStyle(
                                      fontSize: 30.sp,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Flexible(
                                      child: TextFormField(
                                    onTap: () {
                                      updateMasterNum();
                                    },
                                    controller: controller.masterController,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      hintText: '请输入重量',
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLength: 10,
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                          errorText: '重量不能为空'),
                                      (value) {
                                        var masterNumber =
                                            Decimal.tryParse(value!);
                                        if (null == masterNumber) {
                                          return '重量请输入数字';
                                        } else if (masterNumber <=
                                            Decimal.zero) {
                                          return '重量不能小于等于0';
                                        }
                                        return null;
                                      },
                                    ]),
                                  )),
                                  Text(
                                    productDTO.unitDetailDTO?.masterUnitName ??
                                        '',
                                    style: TextStyle(
                                      fontSize: 30.sp,
                                      color: Colors.black87,
                                    ),
                                  )
                                ],
                              ));
                        }),
                    Row(
                      children: [
                        Text(
                          '数量',
                          style: TextStyle(
                            fontSize: 30.sp,
                            color: Colors.black87,
                          ),
                        ),
                        Flexible(
                            child: TextFormField(
                                onTap: () {
                                  updateSlaveNum();
                                },
                                controller: controller.slaveController,
                                decoration: InputDecoration(
                                  counterText: '',
                                  hintText: '请输入数量',
                                ),
                                textAlign: TextAlign.center,
                                maxLength: 10,
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: true, decimal: true),
                                validator: (value) {
                                  var text = controller.slaveController.text;
                                  var slaveNumber = Decimal.tryParse(text);
                                  if (null == slaveNumber) {
                                    return '请正确输入商品数量';
                                  } else if (slaveNumber <= Decimal.zero) {
                                    return '数量不能小于等于0';
                                  }
                                  return null;
                                })),
                        GetBuilder<AddStockDialogController>(
                            id: 'add_stock_number_unit',
                            init: controller,
                            global: false,
                            builder: (_) {
                              return Text(
                                getProductUnitName() ?? '',
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  color: Colors.black87,
                                ),
                              );
                            })
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () => Get.back(),
                      child: Text(
                        '取消',
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState
                                ?.saveAndValidate(focusOnInvalid: true) ??
                            false) {
                          if (onClick(buildContent())) {
                            Get.back();
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
                          backgroundColor: Colours.primary),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  bool isSelectMaster() {
    var unitDetailDTO = productDTO.unitDetailDTO;
    if ((UnitType.MULTI_NUMBER.value == unitDetailDTO?.unitType) ||
        (UnitType.MULTI_WEIGHT.value == unitDetailDTO?.unitType)) {
      return unitDetailDTO?.selectMasterUnit ?? true;
    }
    return false;
  }

  bool isMasterUnitShow() {
    var unitDetailDTO = productDTO.unitDetailDTO;
    if (UnitType.MULTI_WEIGHT.value == unitDetailDTO?.unitType) {
      return unitDetailDTO?.selectMasterUnit ?? true;
    }
    return false;
  }

  buildContent() {
    var productAddStockCarDTO = ProductAddStockCarDTO(
      productId: productDTO.id,
      productName: productDTO.productName,
      productPlace: productDTO.productPlace,
      productStandard: productDTO.productStandard,
    );
    String weight = controller.masterController.text;
    String number = controller.slaveController.text;
    var unitType = productDTO.unitDetailDTO?.unitType;
    if (UnitType.SINGLE.value == unitType) {
      return productAddStockCarDTO.copyWith(number: Decimal.tryParse(number));
    } else {
      var selectMasterUnit = productDTO.unitDetailDTO?.selectMasterUnit ?? true;
      productDTO.unitDetailDTO?.selectMasterUnit = selectMasterUnit;
      if (selectMasterUnit) {
        if (UnitType.MULTI_WEIGHT.value == unitType) {
          return productAddStockCarDTO.copyWith(
            selectMasterUnit: true,
            masterUnitId: productDTO.unitDetailDTO?.masterUnitId,
            slaveUnitId: productDTO.unitDetailDTO?.slaveUnitId,
            masterNumber: Decimal.tryParse(weight),
            slaveNumber: Decimal.tryParse(number),
          );
        }
        return productAddStockCarDTO.copyWith(
          selectMasterUnit: true,
          masterUnitId: productDTO.unitDetailDTO?.masterUnitId,
          slaveUnitId: productDTO.unitDetailDTO?.slaveUnitId,
          masterNumber: Decimal.tryParse(number),
        );
      } else {
        return productAddStockCarDTO.copyWith(
          selectMasterUnit: false,
          masterUnitId: productDTO.unitDetailDTO?.masterUnitId,
          slaveUnitId: productDTO.unitDetailDTO?.slaveUnitId,
          slaveNumber: Decimal.tryParse(number),
        );
      }
    }
  }

  String? getProductUnitName() {
    var unitDetailDTO = productDTO.unitDetailDTO;
    if (UnitType.SINGLE.value == unitDetailDTO?.unitType) {
      return unitDetailDTO?.unitName;
    } else {
      if (UnitType.MULTI_WEIGHT.value == unitDetailDTO?.unitType) {
        return unitDetailDTO?.slaveUnitName;
      }
      return (unitDetailDTO?.selectMasterUnit ?? true)
          ? unitDetailDTO?.masterUnitName
          : unitDetailDTO?.slaveUnitName;
    }
  }

  updateSlaveNum() {
    /// 1、当选择主单位时(计重)，重量变化会引起数量变化
    /// 1、当选择主单位时(计件)，重量变化会引起数量变化
    /// 3、id:'shopping_car_slave_number'
    Decimal? slaveNumber = Decimal.tryParse(controller.slaveController.text);
    if (isSelectMaster()) {
      if (UnitType.MULTI_WEIGHT.value == productDTO.unitDetailDTO?.unitType) {
        String weightStr = controller.masterController.text;
        Decimal? weight = Decimal.tryParse(weightStr);
        Decimal? conversion = productDTO.unitDetailDTO?.conversion;
        if ((weight != null) && (conversion != null)) {
          slaveNumber = DecimalUtil.divide(weight, conversion);
        }
      }
    }
    controller.slaveController.text =
        DecimalUtil.formatDecimalDefault(slaveNumber);
  }

  updateMasterNum() {
    Decimal? masterNumber = Decimal.tryParse(controller.masterController.text);
    if (isSelectMaster()) {
      if (UnitType.MULTI_WEIGHT.value == productDTO.unitDetailDTO?.unitType) {
        Decimal? num = Decimal.tryParse(controller.slaveController.text);
        Decimal? conversion = productDTO.unitDetailDTO?.conversion;
        if ((num != null) && (conversion != null)) {
          masterNumber = num * conversion;
        }
        controller.masterController.text =
            DecimalUtil.formatDecimalDefault(masterNumber);
      }
    }
  }
}
