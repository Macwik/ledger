import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/entity/payment/order_pay_dialog_result.dart';
import 'package:ledger/entity/payment/order_payment_request.dart';
import 'package:ledger/entity/payment/payment_method_dto.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/widget/dialog/single_input_dialog.dart';
import 'package:ledger/widget/dialog_widget/payment_dialog/payment_dialog_binding.dart';
import 'package:ledger/widget/dialog_widget/payment_dialog/payment_dialog_controller.dart';

class PaymentDialog extends StatelessWidget {
  final formKey = GlobalKey<FormBuilderState>();
  late final PaymentDialogController controller;
  final Decimal totalAmount;
  final OrderType orderType;
  final Future<bool> Function(OrderPayDialogResult? result) onClick;
  final List<PaymentMethodDTO> paymentMethods;

  PaymentMethodDTO getPaymentMethod(int id) {
    return paymentMethods.firstWhere((element) => element.id == id);
  }

  PaymentDialog(
      {super.key,
      required this.totalAmount,
      required this.paymentMethods,
      required this.orderType,
      required this.onClick,
      CustomDTO? customDTO}) {
    PaymentDialogBinding().dependencies();
    controller = Get.find<PaymentDialogController>();
    controller.customDTO = customDTO;
    controller.selectPayMethodOne = paymentMethods[3].id;
    controller.selectPayMethodTwo = paymentMethods[3].id;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (ScreenUtil().screenWidth - 80.0.w) * 3.6.w,
      child: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              GetBuilder<PaymentDialogController>(
                id: 'payment_custom',
                init: controller,
                global: false,
                builder: (_) {
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                        left: 20.w, right: 20.w, top: 10.w, bottom: 15.w),
                    child: ElevatedButton(
                      onPressed: () async {
                        var result = await Get.toNamed(RouteConfig.customRecord,
                            arguments: {
                              'initialIndex': (orderType == OrderType.SALE) ||
                                      (orderType == OrderType.SALE_RETURN)
                                  ? 0
                                  : 1,
                              'isSelectCustom': true
                            });
                        controller.customDTO = result;
                        controller.update(
                            ['payment_custom', 'payment_dialog_credit']);
                      },
                      child: Text(
                        controller.customDTO?.customName ?? '选择客户/供应商',
                        style: TextStyle(
                          color: Colours.primary,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(
                          BorderSide(color: Colours.primary),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        elevation: MaterialStateProperty.all(5),
                        overlayColor: MaterialStateProperty.all(
                            Colours.primary.withOpacity(0.1)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.w),
                        )),
                      ),
                    ),
                  );
                },
              ),
              Container(
                padding: EdgeInsets.only(
                    top: 20.w, left: 40.w, right: 40.w, bottom: 40.w),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          '订单金额',
                          style: TextStyle(
                            fontSize: 26.sp,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          height: 28.w,
                        ),
                        Text(
                          DecimalUtil.formatDecimalDefault(totalAmount),
                          style: TextStyle(
                            fontSize: 44.sp,
                            color: Colours.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              // 设置圆角半径，这里以10.0为例
                              side: BorderSide(
                                  color: Colours.primary,
                                  width: 2.0), // 设置边框颜色和宽度
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.white), // 设置背景色
                        ),
                        child: InkWell(
                            onTap: () {
                              inputDiscountDialog();
                            },
                            child: GetBuilder<PaymentDialogController>(
                              id: 'payment_dialog_discount',
                              init: controller,
                              global: false,
                              builder: (_) {
                                return Text(
                                  controller.discountAmount != Decimal.zero
                                      ? '已抹零${DecimalUtil.formatDecimalDefault(controller.discountAmount)}元'
                                      : '抹零',
                                  style: TextStyle(
                                      color: Colours.primary,
                                      fontSize: 26.sp,
                                      fontWeight: FontWeight.w500),
                                );
                              },
                            )))
                  ],
                ),
              ),
              FormBuilder(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      height: 115.w,
                      padding: EdgeInsets.only(left: 40.w, right: 40.w),
                      child: GetBuilder<PaymentDialogController>(
                          id: 'select_payment_first',
                          init: controller,
                          global: false,
                          builder: (_) {
                            return Flex(
                              direction: Axis.horizontal,
                              children: [
                                LoadAssetImage(
                                  getPaymentMethod(
                                          controller.selectPayMethodOne!)
                                      .icon!,
                                  format: ImageFormat.png,
                                  height: 70.w,
                                  width: 70.w,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                DropdownButton<int>(
                                  value: controller.selectPayMethodOne!,
                                  //通过将其赋值给value属性，我们确保该选项被显示为默认选择。
                                  hint: Text(
                                    getPaymentMethod(
                                            controller.selectPayMethodOne!)
                                        .name!,
                                    style: TextStyle(
                                      fontSize: 36.sp,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    size: 50.w,
                                  ),
                                  underline: Container(),
                                  style: TextStyle(color: Colors.black),
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.selectPayMethodOne = value;
                                      controller
                                          .update(['select_payment_first']);
                                    }
                                  },
                                  items: paymentMethods
                                      .map((e) => e.id)
                                      .toList()
                                      .map<DropdownMenuItem<int>>((int? value) {
                                    return DropdownMenuItem<int>(
                                      value: value,
                                      child:
                                          Text(getPaymentMethod(value!).name!),
                                    );
                                  }).toList(),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller:
                                        controller.firstAmountController,
                                    autofocus: true,
                                    maxLength: 13,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      hintText: '请输入金额',
                                    ),
                                    validator: (value) {
                                      if ((null == value) || value.isEmpty) {
                                        return null;
                                      }
                                      bool isValid =
                                          TextUtil.validNumber(value);
                                      if (!isValid) {
                                        return '请正确输入金额！';
                                      }
                                      Decimal? paymentAmount =
                                          Decimal.tryParse(value);
                                      if (null == paymentAmount) {
                                        return '请正确输入金额！';
                                      }
                                      return null;
                                    },
                                    textAlign: TextAlign.center,
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          TextUtil.inputAmountRegExp),
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    onTap: () {
                                      controller.paymentFirstUpdate(totalAmount,
                                          controller.discountAmount);
                                    },
                                  ),
                                ),
                                Text(
                                  '元',
                                  style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            );
                          }),
                    ),
                    Container(
                      color: Colours.divider,
                      height: 1.w,
                      margin: EdgeInsets.only(top: 30.w),
                      width: double.infinity,
                    ),
                    GetBuilder<PaymentDialogController>(
                        id: 'payment_group',
                        init: controller,
                        global: false,
                        builder: (_) {
                          return Visibility(
                              visible: controller.groupPayment,
                              child: Container(
                                color: Colors.white,
                                height: 115.w,
                                padding:
                                    EdgeInsets.only(left: 40.w, right: 40.w),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    LoadAssetImage(
                                      getPaymentMethod(
                                              controller.selectPayMethodTwo!)
                                          .icon!,
                                      format: ImageFormat.png,
                                      height: 70.w,
                                      width: 70.w,
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    DropdownButton<int>(
                                      value: controller.selectPayMethodTwo,
                                      //通过将其赋值给value属性，我们确保该选项被显示为默认选择。
                                      hint: Text(
                                        getPaymentMethod(
                                                controller.selectPayMethodTwo!)
                                            .name!,
                                        style: TextStyle(
                                          fontSize: 36.sp,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        size: 50.w,
                                      ),
                                      underline: Container(),
                                      style: TextStyle(color: Colors.black),
                                      onChanged: (value) {
                                        if (null != value) {
                                          controller.selectPayMethodTwo = value;
                                          controller.update(['payment_group']);
                                        }
                                      },
                                      items: paymentMethods
                                          .map((e) => e.id)
                                          .toList()
                                          .map<DropdownMenuItem<int>>(
                                              (int? value) {
                                        return DropdownMenuItem<int>(
                                          value: value,
                                          child: Text(
                                              getPaymentMethod(value!).name!),
                                        );
                                      }).toList(),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller:
                                            controller.secondAmountController,
                                        maxLength: 13,
                                        decoration: InputDecoration(
                                          counterText: '',
                                          hintText: '请输入金额',
                                        ),
                                        validator: (value) {
                                          if ((null == value) ||
                                              value.isEmpty) {
                                            return null;
                                          }
                                          bool isValid =
                                              TextUtil.validNumber(value);
                                          if (!isValid) {
                                            return '请正确输入金额！';
                                          }
                                          Decimal? paymentAmount =
                                              Decimal.tryParse(value);
                                          if (null == paymentAmount) {
                                            return '请正确输入金额！';
                                          }
                                          if (paymentAmount > totalAmount) {
                                            return '支付金额不能大于订单金额';
                                          }
                                          return null;
                                        },
                                        textAlign: TextAlign.center,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d+\.?\d{0,2}')),
                                          LengthLimitingTextInputFormatter(10),
                                        ],
                                        onTap: () {
                                          controller.paymentTwoUpdate(
                                              totalAmount,
                                              controller.discountAmount);
                                        },
                                      ),
                                    ),
                                    Text(
                                      '元',
                                      style: TextStyle(
                                          fontSize: 28.sp,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ));
                        }),
                    Container(
                        padding: EdgeInsets.only(top: 30.w),
                        child: InkWell(
                          onTap: () {
                            controller.groupPayment = !controller.groupPayment;
                            if (!controller.groupPayment) {
                              controller.secondAmountController.text =
                                  Decimal.zero.toBigInt().toString();
                            }
                            controller.update(
                                ['payment_group', 'payment_group_switch']);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GetBuilder<PaymentDialogController>(
                                  id: 'payment_group_switch',
                                  init: controller,
                                  global: false,
                                  builder: (_) {
                                    return Text(
                                        controller.groupPayment
                                            ? '切换单支付模式'
                                            : '添加付款方式',
                                        style: TextStyle(
                                            fontSize: 28.sp,
                                            color: Colors.black54));
                                  }),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colours.text_ccc,
                              )
                            ],
                          ),
                        )),
                    Container(
                      color: Colours.divider,
                      height: 10.w,
                      margin: EdgeInsets.only(top: 30.w),
                      width: double.infinity,
                    ),

                    /// 赊账
                    GetBuilder<PaymentDialogController>(
                        id: 'payment_dialog_credit',
                        init: controller,
                        global: false,
                        builder: (_) {
                          return (null == controller.customDTO?.id)
                              ? Container(
                                  padding: EdgeInsets.only(
                                      left: 40.w, right: 40.w, top: 50.w),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      LoadAssetImage(
                                        'debt',
                                        format: ImageFormat.png,
                                        height: 70.w,
                                        width: 70.w,
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Text(
                                        '赊账',
                                        style: TextStyle(
                                          fontSize: 36.sp,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '请录入客户后填此项',
                                        style: TextStyle(
                                          fontSize: 26.sp,
                                          color: Colors.redAccent,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.only(
                                      left: 40.w, right: 40.w, top: 50.w),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      LoadAssetImage(
                                        'debt',
                                        format: ImageFormat.png,
                                        height: 70.w,
                                        width: 70.w,
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Text(
                                        '赊账',
                                        style: TextStyle(
                                          fontSize: 36.sp,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          onTap: () {
                                            controller.creditInputUpdate(
                                                totalAmount,
                                                controller.discountAmount);
                                          },
                                          controller:
                                              controller.textEditingController,
                                          decoration: InputDecoration(
                                            counterText: '',
                                            hintText: '请输入金额',
                                          ),
                                          maxLength: 10,
                                          validator: (value) {
                                            if ((null == value) ||
                                                value.isEmpty) {
                                              return null;
                                            }
                                            bool isValid =
                                                TextUtil.validNumber(value);
                                            if (!isValid) {
                                              return '请正确输入金额！';
                                            }
                                            Decimal? paymentAmount =
                                                Decimal.tryParse(value);
                                            if (null == paymentAmount) {
                                              return '请正确输入金额！';
                                            }
                                            if (paymentAmount > totalAmount) {
                                              return '支付金额不能大于订单金额';
                                            }
                                            return null;
                                          },
                                          textAlign: TextAlign.center,
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'^\d+\.?\d{0,2}')),
                                            LengthLimitingTextInputFormatter(
                                                10),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '元',
                                        style: TextStyle(
                                            fontSize: 28.sp,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                );
                        }),
                    Container(
                      color: Colours.divider,
                      height: 1.w,
                      margin: EdgeInsets.only(top: 30.w),
                      width: double.infinity,
                    ),
                Container(
                  padding: EdgeInsets.only(
                      left: 40.w, right: 40.w),
                  child:Row(
                    children: [
                      Text('备注'),
                      Expanded(
                          child: TextFormField(
                            controller: controller.remarkTextEditing,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                              hintText: '请填写',
                            ),
                            style: TextStyle(
                                fontSize: 32.sp
                            ),
                            maxLength: 32,
                            keyboardType: TextInputType.name,
                          ))
                    ],
                  )
                )
                  ],
                ),
              )
            ],
          )),
          Align(
              alignment: Alignment.bottomCenter,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedBtn(
                      onPressed: () => Get.back(),
                      size: Size(double.infinity, 90.w),
                      radius: 15.w,
                      backgroundColor: Colors.white,
                      elevation: 4,
                      child: Text(
                        '取 消',
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedBtn(
                      onPressed: () async {
                        if (formKey.currentState
                                ?.saveAndValidate(focusOnInvalid: false) ??
                            false) {
                          await checkData().then((value) async {
                            if (!value) {
                              return;
                            }
                            await onClick(controller.result)
                                .then((value) async {
                              Get.back();
                            });
                          });
                        }else {
                          Toast.show('保存失败，请重试');
                        }
                      },
                      size: Size(double.infinity, 90.w),
                      radius: 15.w,
                      backgroundColor: Colours.primary,
                      child: Text(
                        '确 认',
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  void inputDiscountDialog() {
    var roundToZero = DecimalUtil.roundToZero(totalAmount);
    SingleInputDialog().singleInputDialog(
      title: '请输入抹零金额',
      controller: TextEditingController(
          text: DecimalUtil.formatDecimalDefault(roundToZero)),
      keyboardType: TextInputType.number,
      validator: FormBuilderValidators.required(errorText: '抹零金额不能为空'.tr),
      onOkPressed: (value) {
        controller.discountAmount = Decimal.tryParse(value) ?? Decimal.zero;
        controller.update(['payment_dialog_discount']);
        return Future(() => true);
      },
    );
  }

  Future<bool> checkData() async {
    List<OrderPaymentRequest> orderPaymentRequest = [];
    String? paymentAmountFirst = controller.firstAmountController.text;
    String? paymentMethodSecond = controller.secondAmountController.text;
    Decimal paymentFirst = Decimal.tryParse(paymentAmountFirst) ?? Decimal.zero;
    Decimal paymentSecond =
        Decimal.tryParse(paymentMethodSecond) ?? Decimal.zero;

    if (paymentFirst > Decimal.zero) {
      orderPaymentRequest.add(OrderPaymentRequest(
          paymentMethodId: controller.selectPayMethodOne,
          paymentAmount: paymentFirst,
          ordinal: 0));
    }

    var creditAmountStr = controller.textEditingController.text;
    Decimal creditAmount = Decimal.tryParse(creditAmountStr) ?? Decimal.zero;

    if (totalAmount !=
        (controller.discountAmount + creditAmount + paymentFirst + paymentSecond)) {
      await Get.defaultDialog(
          title: '提示',
          middleText: '订单金额需等于 抹零 + 支付金额 + 赊账金额',
          middleTextStyle: TextStyle(
            fontSize: 30.sp,
          ),
          onConfirm: () => Get.back());
      return false;
    }
    if (controller.groupPayment) {
      if (paymentSecond > Decimal.zero) {
        orderPaymentRequest.add(OrderPaymentRequest(
            paymentMethodId: controller.selectPayMethodTwo,
            paymentAmount: paymentSecond,
            ordinal: 1));
      }
    }
    controller.result = OrderPayDialogResult(
        discountAmount: controller.discountAmount,
        creditAmount: creditAmount,
        customDTO: controller.customDTO,
        remark:controller.remarkTextEditing.text,
        orderPaymentRequest: orderPaymentRequest);
    return true;
  }
}
