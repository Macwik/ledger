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

class AddStockDialog<T extends GetxController> extends StatelessWidget {
  final formKey = GlobalKey<FormBuilderState>();

  final TextEditingController masterController = TextEditingController();
  final TextEditingController slaveController = TextEditingController();
  // final TextEditingController amountController = TextEditingController();
  // final TextEditingController priceController = TextEditingController();

  final T controller;
  final ProductDTO productDTO;
  final OrderType? orderType;
  final Function(ProductShoppingCarDTO result) onClick;

  AddStockDialog(
      {required this.productDTO,
        required this.orderType,
        required this.controller,
        required this.onClick}) {
    // priceController.addListener(updateShoppingCarTotalAmount);
    //
    // amountController.addListener(updatePrice);

    masterController.addListener(() {
      String? masterNum = masterController.text;
      Decimal? masterNumber = Decimal.tryParse(masterNum);
      if (null == masterNumber) {
        return;
      }
      var masterStock = productDTO.unitDetailDTO?.masterStock;
      if (null != masterStock && masterStock < masterNumber) {
        if (orderType == OrderType.SALE) {
          isStockEnough();
        }
      }
    });
    slaveController.addListener(() {
      String? slaveNum = slaveController.text;
      Decimal? slaveNumber = Decimal.tryParse(slaveNum);
      if (null == slaveNumber) {
        return;
      }
      if (productDTO.unitDetailDTO?.unitType == UnitType.SINGLE.value) {
        var stock = productDTO.unitDetailDTO?.stock;
        if ((stock != null) && stock < slaveNumber) {
          if (orderType == OrderType.SALE) {
            isStockEnough();
          }
        }
      } else {
        if (productDTO.unitDetailDTO?.unitType == UnitType.MULTI_NUMBER.value &&
            isSelectMaster()) {
          var stock = productDTO.unitDetailDTO?.masterStock;
          if ((stock != null) && stock < slaveNumber) {
            if (orderType == OrderType.SALE) {
              isStockEnough();
            }
          }
        } else {
          var stock = productDTO.unitDetailDTO?.slaveStock;
          if ((stock != null) && stock < slaveNumber) {
            if (orderType == OrderType.SALE) {
              isStockEnough();
            }
          }
        }
      }
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
                child: GetBuilder<T>(
                    id: 'shopping_car_unit',
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
                                        masterController.text = '';
                                        slaveController.text = '';
                                        productDTO.unitDetailDTO
                                            ?.selectMasterUnit = true;
                                        controller.update([
                                          'shopping_car_unit',
                                          'shopping_car_master_number',
                                          'shopping_car_number_unit',
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
                                          masterController.text = '';
                                          slaveController.text = '';
                                          productDTO.unitDetailDTO
                                              ?.selectMasterUnit = false;
                                          controller.update([
                                            'shopping_car_unit',
                                            'shopping_car_master_number',
                                            'shopping_car_number_unit',
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
                    GetBuilder<T>(
                        id: 'shopping_car_master_number',
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
                                        controller: masterController,
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
                                controller: slaveController,
                                decoration: InputDecoration(
                                  counterText: '',
                                  hintText: '请输入数量',
                                ),
                                textAlign: TextAlign.center,
                                maxLength: 10,
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: true, decimal: true),
                                validator: (value) {
                                  var text = slaveController.text;
                                  var slaveNumber = Decimal.tryParse(text);
                                  if (null == slaveNumber) {
                                    return '请正确输入商品数量';
                                  } else if (slaveNumber <= Decimal.zero) {
                                    return '数量不能小于等于0';
                                  }
                                  return null;
                                })),
                        GetBuilder<T>(
                            id: 'shopping_car_number_unit',
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
                    // Row(
                    //   children: [
                    //     Text(
                    //       '单价',
                    //       style: TextStyle(
                    //         fontSize: 30.sp,
                    //         color: Colors.black87,
                    //       ),
                    //     ),
                    //     Flexible(
                    //         child: TextFormField(
                    //             onTap: () {
                    //               updatePrice();
                    //             },
                    //             controller: priceController,
                    //             decoration: InputDecoration(
                    //               counterText: '',
                    //               hintText: '请输入单价',
                    //             ),
                    //             textAlign: TextAlign.center,
                    //             maxLength: 10,
                    //             keyboardType: TextInputType.numberWithOptions(
                    //                 signed: true, decimal: true),
                    //             validator: (value) {
                    //               var text = priceController.text;
                    //               var price = Decimal.tryParse(text);
                    //               if (null == price) {
                    //                 return '请正确输入单价';
                    //               } else if (price <= Decimal.zero) {
                    //                 return '单价不能小于等于0';
                    //               }
                    //               return null;
                    //             })),
                    //     GetBuilder<T>(
                    //         id: 'shopping_car_price_unit_name',
                    //         builder: (_) {
                    //           return Text(
                    //             '元/${getProductPriceUnitName() ?? ''}',
                    //             style: TextStyle(
                    //                 fontSize: 30.sp,
                    //                 color: Colors.redAccent,
                    //                 fontWeight: FontWeight.w600
                    //             ),
                    //           );
                    //         })
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       '总价',
                    //       style: TextStyle(
                    //         fontSize: 30.sp,
                    //         color: Colors.black87,
                    //       ),
                    //     ),
                    //     Flexible(
                    //         child: TextFormField(
                    //             onTap: () {
                    //               updateShoppingCarTotalAmount();
                    //             },
                    //             controller: amountController,
                    //             decoration: InputDecoration(
                    //               counterText: '',
                    //               hintText: '请输入总价',
                    //             ),
                    //             textAlign: TextAlign.center,
                    //             maxLength: 10,
                    //             keyboardType: TextInputType.numberWithOptions(
                    //                 signed: true, decimal: true),
                    //             validator: (value) {
                    //               var text = amountController.text;
                    //               var repaymentAmount = Decimal.tryParse(text);
                    //               if (null == repaymentAmount) {
                    //                 return '请正确输入总价';
                    //               } else if (repaymentAmount <= Decimal.zero) {
                    //                 return '总价不能小于等于0';
                    //               }
                    //               return null;
                    //             })),
                    //     Text(
                    //       '元',
                    //       style: TextStyle(
                    //         fontSize: 30.sp,
                    //         color: Colors.black87,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // SizedBox(height: 10)
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
    return ProductShoppingCarDTO(
        productId: productDTO.id,
        productName: productDTO.productName,
        productPlace: productDTO.productPlace,
        productStandard: productDTO.productStandard,
        unitDetailDTO: getUnitDetailDTO());
  }

  UnitDetailDTO? getUnitDetailDTO() {
    String weight = masterController.text;
    String number = slaveController.text;
    var unitType = productDTO.unitDetailDTO?.unitType;
    if (UnitType.SINGLE.value == unitType) {
      return productDTO.unitDetailDTO?.copyWith(
          number: Decimal.tryParse(number),
         );
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
             );
        }
        return productDTO.unitDetailDTO?.copyWith(
            selectMasterUnit: true,
            masterUnitId: productDTO.unitDetailDTO?.masterUnitId,
            slaveUnitId: productDTO.unitDetailDTO?.slaveUnitId,
            masterNumber: Decimal.tryParse(number),
           );
      } else {
        return productDTO.unitDetailDTO?.copyWith(
            selectMasterUnit: false,
            masterUnitId: productDTO.unitDetailDTO?.masterUnitId,
            slaveUnitId: productDTO.unitDetailDTO?.slaveUnitId,
            slaveNumber: Decimal.tryParse(number),
           );
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

  void isStockEnough() {
    Get.dialog(
        AlertDialog(title: Text('是否继续开单'), content: Text('库存不足以开单'), actions: [
          TextButton(
            child: Text('取消'),
            onPressed: () {
              Get.until((route) {
                return route.settings.name == RouteConfig.shoppingCar;
              });
            },
          ),
          TextButton(
            child: Text('确定'),
            onPressed: () {
              Get.back();
            },
          ),
        ]));
  }

  // void updatePrice() {
  //   var unitType = productDTO.unitDetailDTO?.unitType;
  //   Decimal? priceAmount = Decimal.tryParse(priceController.text);
  //   if (isSelectMaster()) {
  //     //主单位时候
  //     String weight;
  //     if (UnitType.MULTI_NUMBER.value == unitType) {
  //       weight = slaveController.text;
  //     } else {
  //       weight = masterController.text;
  //     }
  //     String amount = amountController.text;
  //     Decimal? productWeight = Decimal.tryParse(weight);
  //     Decimal? productAmount = Decimal.tryParse(amount);
  //     if ((productAmount != null && (productWeight != null))) {
  //       priceAmount = DecimalUtil.divide(productAmount, productWeight);
  //     }
  //   } else {
  //     //辅助单位时候
  //     String number = slaveController.text;
  //     String amount = amountController.text;
  //     Decimal? productWeight = Decimal.tryParse(number);
  //     Decimal? productAmount = Decimal.tryParse(amount);
  //     if ((productAmount != null) && (productWeight != null)) {
  //       priceAmount = DecimalUtil.divide(productAmount, productWeight);
  //     }
  //   }
  //   priceController.removeListener(updateShoppingCarTotalAmount);
  //   priceController.text = DecimalUtil.formatDecimalDefault(priceAmount);
  //   priceController.addListener(updateShoppingCarTotalAmount);
  // }

  updateSlaveNum() {
    /// 1、当选择主单位时(计重)，重量变化会引起数量变化
    /// 1、当选择主单位时(计件)，重量变化会引起数量变化
    /// 3、id:'shopping_car_slave_number'
    Decimal? slaveNumber = Decimal.tryParse(slaveController.text);
    if (isSelectMaster()) {
      if (UnitType.MULTI_WEIGHT.value == productDTO.unitDetailDTO?.unitType) {
        String weightStr = masterController.text;
        Decimal? weight = Decimal.tryParse(weightStr);
        Decimal? conversion = productDTO.unitDetailDTO?.conversion;
        if ((weight != null) && (conversion != null)) {
          slaveNumber = DecimalUtil.divide(weight, conversion);
        }
      }
    }
    slaveController.text = DecimalUtil.formatDecimalDefault(slaveNumber);
  }

  updateMasterNum() {
    Decimal? masterNumber = Decimal.tryParse(masterController.text);
    if (isSelectMaster()) {
      if (UnitType.MULTI_WEIGHT.value == productDTO.unitDetailDTO?.unitType) {
        Decimal? num = Decimal.tryParse(slaveController.text);
        Decimal? conversion = productDTO.unitDetailDTO?.conversion;
        if ((num != null) && (conversion != null)) {
          masterNumber = num * conversion;
        }
        masterController.text = DecimalUtil.formatDecimalDefault(masterNumber);
      }
    }
  }

  // updateShoppingCarTotalAmount() {
  //   var unitType = productDTO.unitDetailDTO?.unitType;
  //   Decimal? amountNumber = Decimal.tryParse(amountController.text);
  //   if (isSelectMaster()) {
  //     //主单位时候
  //     if (UnitType.MULTI_NUMBER.value == unitType) {
  //       String numberStr = slaveController.text;
  //       String priceStr = priceController.text;
  //       Decimal? productNumber = Decimal.tryParse(numberStr);
  //       Decimal? productPrice = Decimal.tryParse(priceStr);
  //       if ((productNumber != null) && (productPrice != null)) {
  //         amountNumber = (productNumber * productPrice);
  //       }
  //     } else if (UnitType.MULTI_WEIGHT.value == unitType) {
  //       String numberStr = masterController.text;
  //       String priceStr = priceController.text;
  //       Decimal? productNumber = Decimal.tryParse(numberStr);
  //       Decimal? productPrice = Decimal.tryParse(priceStr);
  //       if ((productNumber != null) && (productPrice != null)) {
  //         amountNumber = (productNumber * productPrice);
  //       }
  //     }
  //   } else {
  //     //辅助单位时候
  //     String numberStr = slaveController.text;
  //     String priceStr = priceController.text;
  //     Decimal? productNumber = Decimal.tryParse(numberStr);
  //     Decimal? productPrice = Decimal.tryParse(priceStr);
  //     if ((productNumber != null) && (productPrice != null)) {
  //       amountNumber = (productNumber * productPrice);
  //     }
  //   }
  //   amountController.removeListener(updatePrice);
  //   amountController.text = DecimalUtil.formatDecimalDefault(amountNumber);
  //   amountController.addListener(updatePrice);
  // }
}
