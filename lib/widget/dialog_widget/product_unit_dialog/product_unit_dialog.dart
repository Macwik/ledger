import 'package:decimal/decimal.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/product/product_shopping_car_dto.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/entity/unit/unit_detail_dto.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/unit_type.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/widget/dialog_widget/product_unit_dialog/product_unit_dialog_binding.dart';
import 'package:ledger/widget/dialog_widget/product_unit_dialog/product_unit_dialog_controller.dart';

class ProductUnitDialog extends StatelessWidget {
  final formKey = GlobalKey<FormBuilderState>();

  late final ProductUnitDialogController controller;
  final ProductDTO productDTO;
  final OrderType? orderType;
  final Function(ProductShoppingCarDTO result) onClick;

  ProductUnitDialog(
      {required this.productDTO,
      required this.orderType,
      required this.onClick}) {
    ProductUnitDialogBinding().dependencies();
    controller = Get.find<ProductUnitDialogController>();

    controller.priceController.addListener(updateShoppingCarTotalAmount);
    controller.amountController.addListener(updatePrice);

    controller.masterController.addListener(() {
      String? masterNum = controller.masterController.text;
      Decimal? masterNumber = Decimal.tryParse(masterNum);
      if (null == masterNumber) {
        return;
      }
      updateShoppingCarTotalAmount();
    });

    controller.slaveController.addListener(() {
      String? slaveNum = controller.slaveController.text;
      Decimal? slaveNumber = Decimal.tryParse(slaveNum);
      if (null == slaveNumber) {
        return;
      }
      updateShoppingCarTotalAmount();
    });
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
                child: GetBuilder<ProductUnitDialogController>(
                    id: 'shopping_car_unit',
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
                                        controller.amountController.text = '';
                                        controller.priceController.text = '';
                                        productDTO.unitDetailDTO
                                            ?.selectMasterUnit = true;
                                        controller.update([
                                          'shopping_car_unit',
                                          'shopping_car_master_number',
                                          'shopping_car_number_unit',
                                          'shopping_car_price_unit_name'
                                        ]);
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
                                      controller.amountController.text = '';
                                      controller.priceController.text = '';
                                      productDTO.unitDetailDTO
                                          ?.selectMasterUnit = false;
                                      controller.update([
                                        'shopping_car_unit',
                                        'shopping_car_master_number',
                                        'shopping_car_number_unit',
                                        'shopping_car_price_unit_name',
                                      ]);
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
                    GetBuilder<ProductUnitDialogController>(
                        id: 'shopping_car_master_number',
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
                                    maxLength: 8,
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
                                maxLength: 8,
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
                        GetBuilder<ProductUnitDialogController>(
                            id: 'shopping_car_number_unit',
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
                    Row(
                      children: [
                        Text(
                          '单价',
                          style: TextStyle(
                            fontSize: 30.sp,
                            color: Colors.black87,
                          ),
                        ),
                        Flexible(
                            child: TextFormField(
                                onTap: () {
                                  updatePrice();
                                },
                                controller: controller.priceController,
                                decoration: InputDecoration(
                                  counterText: '',
                                  hintText: '请输入单价',
                                ),
                                textAlign: TextAlign.center,
                                maxLength: 8,
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: true, decimal: true),
                                validator: (value) {
                                  var text = controller.priceController.text;
                                  var price = Decimal.tryParse(text);
                                  if (null == price) {
                                    return '请正确输入单价';
                                  } else if (price <= Decimal.zero) {
                                    return '单价不能小于等于0';
                                  }
                                  return null;
                                })),
                        GetBuilder<ProductUnitDialogController>(
                            id: 'shopping_car_price_unit_name',
                            init: controller,
                            global: false,
                            builder: (_) {
                              return Text(
                                '元/${getProductPriceUnitName() ?? ''}',
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w600),
                              );
                            })
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '总价',
                          style: TextStyle(
                            fontSize: 30.sp,
                            color: Colors.black87,
                          ),
                        ),
                        Flexible(
                            child: TextFormField(
                                onTap: () {
                                  updateShoppingCarTotalAmount();
                                },
                                controller: controller.amountController,
                                decoration: InputDecoration(
                                  counterText: '',
                                  hintText: '请输入总价',
                                ),
                                textAlign: TextAlign.center,
                                maxLength: 13,
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: true, decimal: true),
                                validator: (value) {
                                  var text = controller.amountController.text;
                                  var repaymentAmount = Decimal.tryParse(text);
                                  if (null == repaymentAmount) {
                                    return '请正确输入总价';
                                  } else if (repaymentAmount <= Decimal.zero) {
                                    return '总价不能小于等于0';
                                  }
                                  return null;
                                })),
                        Text(
                          '元',
                          style: TextStyle(
                            fontSize: 30.sp,
                            color: Colors.black87,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10)
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
                        if (formKey.currentState?.saveAndValidate(focusOnInvalid: true) ?? false) {
                          if (onClick(buildContent())) {
                            Get.back();
                          } else {
                            Toast.show('添加失败，请重试');
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
    return ProductShoppingCarDTO(
        productId: productDTO.id,
        productName: productDTO.productName,
        productPlace: productDTO.productPlace,
        productStandard: productDTO.productStandard,
        unitDetailDTO: getUnitDetailDTO());
  }

  UnitDetailDTO? getUnitDetailDTO() {
    String weight = controller.masterController.text;
    String number = controller.slaveController.text;
    String price = controller.priceController.text;
    String totalAmount = controller.amountController.text;
    var unitType = productDTO.unitDetailDTO?.unitType;
    if (UnitType.SINGLE.value == unitType) {
      return productDTO.unitDetailDTO?.copyWith(
          number: Decimal.tryParse(number),
          price: Decimal.tryParse(price),
          totalAmount: Decimal.tryParse(totalAmount));
    } else {
      var selectMasterUnit = productDTO.unitDetailDTO?.selectMasterUnit ?? true;
      productDTO.unitDetailDTO?.selectMasterUnit = selectMasterUnit;
      if (selectMasterUnit) {
        if (UnitType.MULTI_WEIGHT.value == unitType) {
          return productDTO.unitDetailDTO?.copyWith(
              selectMasterUnit: true,
              masterUnitId: productDTO.unitDetailDTO?.masterUnitId,
              slaveUnitId: productDTO.unitDetailDTO?.slaveUnitId,
              masterNumber: Decimal.tryParse(weight),
              slaveNumber: Decimal.tryParse(number),
              masterPrice: Decimal.tryParse(price),
              totalAmount: Decimal.tryParse(totalAmount));
        }
        return productDTO.unitDetailDTO?.copyWith(
            selectMasterUnit: true,
            masterUnitId: productDTO.unitDetailDTO?.masterUnitId,
            slaveUnitId: productDTO.unitDetailDTO?.slaveUnitId,
            masterNumber: Decimal.tryParse(number),
            slaveNumber: DecimalUtil.divide(Decimal.tryParse(number), (productDTO.unitDetailDTO?.conversion ?? Decimal.one)),
            masterPrice: Decimal.tryParse(price),
            totalAmount: Decimal.tryParse(totalAmount));
      } else {
        return productDTO.unitDetailDTO?.copyWith(
            selectMasterUnit: false,
            masterUnitId: productDTO.unitDetailDTO?.masterUnitId,
            slaveUnitId: productDTO.unitDetailDTO?.slaveUnitId,
            masterNumber: (Decimal.tryParse(number) ?? Decimal.zero) * (productDTO.unitDetailDTO?.conversion ?? Decimal.zero),
            slaveNumber: Decimal.tryParse(number),
            slavePrice: Decimal.tryParse(price),
            totalAmount: Decimal.tryParse(totalAmount));
      }
    }
  }

  String? getProductPriceUnitName() {
    var unitDetailDTO = productDTO.unitDetailDTO;
    if (UnitType.SINGLE.value == unitDetailDTO?.unitType) {
      return unitDetailDTO?.unitName;
    } else {
      return (productDTO.unitDetailDTO?.selectMasterUnit ?? true)
          ? unitDetailDTO?.masterUnitName
          : unitDetailDTO?.slaveUnitName;
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


  void updatePrice() {
    var unitType = productDTO.unitDetailDTO?.unitType;
    Decimal? priceAmount = Decimal.tryParse(controller.priceController.text);
    if (isSelectMaster()) {
      //主单位时候
      String weight;
      if (UnitType.MULTI_NUMBER.value == unitType) {
        weight = controller.slaveController.text;
      } else {
        weight = controller.masterController.text;
      }
      String amount = controller.amountController.text;
      Decimal? productWeight = Decimal.tryParse(weight);
      Decimal? productAmount = Decimal.tryParse(amount);
      if ((productAmount != null && (productWeight != null))) {
        priceAmount = DecimalUtil.divide(productAmount, productWeight);
      }
    } else {
      //辅助单位时候
      String number = controller.slaveController.text;
      String amount = controller.amountController.text;
      Decimal? productWeight = Decimal.tryParse(number);
      Decimal? productAmount = Decimal.tryParse(amount);
      if ((productAmount != null) && (productWeight != null)) {
        priceAmount = DecimalUtil.divide(productAmount, productWeight);
      }
    }
    controller.priceController.removeListener(updateShoppingCarTotalAmount);
    controller.priceController.text =
        DecimalUtil.formatDecimalDefault(priceAmount);
    controller.priceController.addListener(updateShoppingCarTotalAmount);
  }

  updateSlaveNum() {
    /// 1、当选择主单位时(计重)，重量变化会引起数量变化
    /// 1、当选择主单位时(计件)，重量变化会引起数量变化
    /// 2、当选择辅助单位时，数量变化会引起总价变化
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
      } else if (UnitType.MULTI_NUMBER.value ==
          productDTO.unitDetailDTO?.unitType) {
        String amountStr = controller.amountController.text;
        Decimal? amount = Decimal.tryParse(amountStr);
        String priceStr = controller.priceController.text;
        Decimal? price = Decimal.tryParse(priceStr);
        if ((null != amount) && (null != price)) {
          slaveNumber = DecimalUtil.divide(amount, price);
        }
      }
    } else {
      String amountStr = controller.amountController.text;
      Decimal? amount = Decimal.tryParse(amountStr);
      String priceStr = controller.priceController.text;
      Decimal? price = Decimal.tryParse(priceStr);
      if ((null != amount) && (null != price)) {
        slaveNumber = DecimalUtil.divide(amount, price);
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

  updateShoppingCarTotalAmount() {
    var unitType = productDTO.unitDetailDTO?.unitType;
    Decimal? amountNumber = Decimal.tryParse(controller.amountController.text);
    if (isSelectMaster()) {
      //主单位时候
      if (UnitType.MULTI_NUMBER.value == unitType) {
        String numberStr = controller.slaveController.text;
        String priceStr = controller.priceController.text;
        Decimal? productNumber = Decimal.tryParse(numberStr);
        Decimal? productPrice = Decimal.tryParse(priceStr);
        if ((productNumber != null) && (productPrice != null)) {
          amountNumber = (productNumber * productPrice);
        }
      } else if (UnitType.MULTI_WEIGHT.value == unitType) {
        String numberStr = controller.masterController.text;
        String priceStr = controller.priceController.text;
        Decimal? productNumber = Decimal.tryParse(numberStr);
        Decimal? productPrice = Decimal.tryParse(priceStr);
        if ((productNumber != null) && (productPrice != null)) {
          amountNumber = (productNumber * productPrice);
        }
      }
    } else {
      //辅助单位时候
      String numberStr = controller.slaveController.text;
      String priceStr = controller.priceController.text;
      Decimal? productNumber = Decimal.tryParse(numberStr);
      Decimal? productPrice = Decimal.tryParse(priceStr);
      if ((productNumber != null) && (productPrice != null)) {
        amountNumber = (productNumber * productPrice);
      }
    }
    controller.amountController.removeListener(updatePrice);
    controller.amountController.text =
        DecimalUtil.formatDecimalDefault(amountNumber);
    controller.amountController.addListener(updatePrice);
  }
}
